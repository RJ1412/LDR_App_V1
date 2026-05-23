# Supabase migration: initial schema for LDR app

-- Enable RLS on all tables

CREATE SCHEMA IF NOT EXISTS public;

-- Users table
CREATE TABLE IF NOT EXISTS public.users (
    id uuid PRIMARY KEY,
    email text NOT NULL UNIQUE,
    created_at timestamp with time zone DEFAULT now()
);

-- Couples table (links two users)
CREATE TABLE IF NOT EXISTS public.couples (
    id uuid PRIMARY KEY,
    user_a_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    user_b_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    created_at timestamp with time zone DEFAULT now(),
    UNIQUE (user_a_id, user_b_id)
);

-- Daily check‑ins table
CREATE TABLE IF NOT EXISTS public.check_ins (
    id uuid PRIMARY KEY,
    couple_id uuid NOT NULL REFERENCES public.couples(id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    mood integer NOT NULL, -- 1‑5 scale
    note text,
    created_at timestamp with time zone DEFAULT now()
);

-- Streaks view (materialized for quick lookup)
CREATE MATERIALIZED VIEW IF NOT EXISTS public.user_streaks AS
SELECT
    user_id,
    COUNT(*) FILTER (WHERE created_at >= (now() - interval '1 day')) AS today_check_ins,
    COUNT(*) FILTER (WHERE created_at >= (now() - interval '7 days')) AS week_check_ins,
    MAX(created_at) AS last_check_in
FROM public.check_ins
GROUP BY user_id;

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_check_ins_couple_user ON public.check_ins (couple_id, user_id);
CREATE INDEX IF NOT EXISTS idx_check_ins_created_at ON public.check_ins (created_at DESC);

-- Row Level Security policies
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.couples ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.check_ins ENABLE ROW LEVEL SECURITY;

-- Users: allow each user to access their own row
CREATE POLICY "users_self" ON public.users
    FOR SELECT USING (auth.uid() = id);
CREATE POLICY "users_self_modify" ON public.users
    FOR INSERT, UPDATE, DELETE USING (auth.uid() = id);

-- Couples: allow members of the couple to read/write
CREATE POLICY "couple_members" ON public.couples
    USING (auth.uid() = user_a_id OR auth.uid() = user_b_id);
CREATE POLICY "couple_members_modify" ON public.couples
    FOR INSERT, UPDATE, DELETE USING (auth.uid() = user_a_id OR auth.uid() = user_b_id);

-- Check‑ins: allow only participants of the couple to insert/read their own check‑ins
CREATE POLICY "check_ins_access" ON public.check_ins
    USING (auth.uid() = user_id);
CREATE POLICY "check_ins_modify" ON public.check_ins
    FOR INSERT, UPDATE, DELETE USING (auth.uid() = user_id);

-- Refresh materialized view on data change (trigger)
CREATE OR REPLACE FUNCTION public.refresh_user_streaks()
RETURNS trigger AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.user_streaks;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_refresh_streaks AFTER INSERT OR UPDATE OR DELETE ON public.check_ins
FOR EACH STATEMENT EXECUTE FUNCTION public.refresh_user_streaks();

-- Ensure RLS policies are applied
ALTER TABLE public.users FORCE ROW LEVEL SECURITY;
ALTER TABLE public.couples FORCE ROW LEVEL SECURITY;
ALTER TABLE public.check_ins FORCE ROW LEVEL SECURITY;
