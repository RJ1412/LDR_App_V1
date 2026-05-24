-- 1. Rename columns if they still use the old 'user_' prefix
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='couples' AND column_name='user_a_id') THEN
    ALTER TABLE public.couples RENAME COLUMN user_a_id TO partner_a_id;
  END IF;
  
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='couples' AND column_name='user_b_id') THEN
    ALTER TABLE public.couples RENAME COLUMN user_b_id TO partner_b_id;
  END IF;
END $$;

-- 2. Make partner_b_id optional so a user can create a space solo
ALTER TABLE public.couples ALTER COLUMN partner_b_id DROP NOT NULL;

-- 3. Add missing fields to couples table
ALTER TABLE public.couples 
  ADD COLUMN IF NOT EXISTS invite_code varchar,
  ADD COLUMN IF NOT EXISTS is_active boolean DEFAULT true,
  ADD COLUMN IF NOT EXISTS space_name varchar,
  ADD COLUMN IF NOT EXISTS anniversary_date date,
  ADD COLUMN IF NOT EXISTS welcome_message text,
  ADD COLUMN IF NOT EXISTS cover_photo_url varchar;

-- 4. Add missing fields to users table
ALTER TABLE public.users
  ADD COLUMN IF NOT EXISTS updated_at timestamp with time zone DEFAULT now(),
  ADD COLUMN IF NOT EXISTS display_name text,
  ADD COLUMN IF NOT EXISTS avatar_url varchar,
  ADD COLUMN IF NOT EXISTS couple_id uuid REFERENCES public.couples(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS fcm_token varchar,
  ADD COLUMN IF NOT EXISTS timezone varchar DEFAULT 'UTC',
  ADD COLUMN IF NOT EXISTS premium_tier boolean DEFAULT false;

-- 5. Add an index for the invite code for faster lookups
CREATE INDEX IF NOT EXISTS idx_couples_invite_code ON public.couples (invite_code);

-- 6. Create the join_couple RPC
CREATE OR REPLACE FUNCTION public.join_couple(invite_code_input text)
RETURNS public.couples AS $$
DECLARE
    found_couple public.couples;
BEGIN
    -- Find the couple by invite code
    SELECT * INTO found_couple 
    FROM public.couples 
    WHERE invite_code = invite_code_input;

    IF found_couple.id IS NULL THEN
        RAISE EXCEPTION 'Invalid invite code';
    END IF;

    IF found_couple.partner_2_id IS NOT NULL THEN
        RAISE EXCEPTION 'This couple is already full.';
    END IF;

    IF found_couple.partner_1_id = auth.uid() THEN
        RAISE EXCEPTION 'You are already in this couple.';
    END IF;

    -- Update the couple
    UPDATE public.couples
    SET partner_2_id = auth.uid()
    WHERE id = found_couple.id
    RETURNING * INTO found_couple;

    -- Update the user's couple_id
    UPDATE public.users
    SET couple_id = found_couple.id
    WHERE id = auth.uid();

    RETURN found_couple;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
