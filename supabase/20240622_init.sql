-- 20240622_init.sql
-- Core tables for the LDR emotional‑sync MVP
-- ----------------------------------------------------
-- 1️⃣ Users (managed by Supabase Auth)
--    The `auth.users` table is provided automatically.
-- ----------------------------------------------------
-- 2️⃣ Couples – a simple join table to pair two auth users.
create table public.couples (
    id               uuid      primary key default uuid_generate_v4(),
    partner_a_id     uuid      not null references auth.users(id) on delete cascade,
    partner_b_id     uuid      not null references auth.users(id) on delete cascade,
    created_at       timestamp with time zone default now(),
    unique (partner_a_id, partner_b_id)
);

-- ----------------------------------------------------
-- 3️⃣ Daily check‑ins
create table public.check_ins (
    id               uuid      primary key default uuid_generate_v4(),
    couple_id        uuid      not null references public.couples(id) on delete cascade,
    user_id          uuid      not null references auth.users(id) on delete cascade,
    mood_score       int       not null check (mood_score >= 0 and mood_score <= 10),
    note             text,
    created_at       timestamp with time zone default now()
);

-- ----------------------------------------------------
-- 4️⃣ Streaks – pre‑computed per couple for quick UI
create table public.couple_streaks (
    couple_id        uuid      primary key references public.couples(id) on delete cascade,
    current_streak   int       not null default 0,
    longest_streak   int       not null default 0,
    last_check_in_at timestamp with time zone
);

-- ----------------------------------------------------
-- Indexes for fast look‑ups
create index idx_check_ins_couple_user on public.check_ins (couple_id, user_id);
create index idx_check_ins_created on public.check_ins (created_at desc);
create index idx_couples_partner_a on public.couples (partner_a_id);
create index idx_couples_partner_b on public.couples (partner_b_id);

-- ----------------------------------------------------
-- Row‑Level Security (RLS) – only owners can read/write
alter table public.couples enable row level security;
alter table public.check_ins enable row level security;
alter table public.couple_streaks enable row level security;

-- Couples: a user can see a couple when they are either partner A or B
create policy "couple_owner"
    on public.couples
    for all
    using (auth.uid() = partner_a_id or auth.uid() = partner_b_id);

-- Check‑ins: a user can insert/read them only for couples they belong to
create policy "check_ins_owner"
    on public.check_ins
    for all
    using (auth.uid() = user_id and
           (auth.uid() = (select partner_a_id from public.couples where id = couple_id) or
            auth.uid() = (select partner_b_id from public.couples where id = couple_id)));

-- Streaks: read/write only by couple members
create policy "streak_owner"
    on public.couple_streaks
    for all
    using (auth.uid() = (select partner_a_id from public.couples where id = couple_id) or
           auth.uid() = (select partner_b_id from public.couples where id = couple_id));

-- ----------------------------------------------------
-- Triggers – keep streaks in sync
create function public.update_couple_streak() returns trigger language plpgsql as $$
declare
    today date := current_date;
    yesterday date := today - interval '1 day';
    last_date date;
begin
    -- fetch the most recent check‑in for this couple (any partner)
    select max(created_at)::date into last_date
      from public.check_ins
     where couple_id = NEW.couple_id;

    if last_date = yesterday then
        -- continue streak
        update public.couple_streaks
           set current_streak = current_streak + 1,
               longest_streak = greatest(longest_streak, current_streak + 1),
               last_check_in_at = now()
         where couple_id = NEW.couple_id;
    elsif last_date <> today then
        -- reset streak (missed a day)
        update public.couple_streaks
           set current_streak = 1,
               longest_streak = greatest(longest_streak, 1),
               last_check_in_at = now()
         where couple_id = NEW.couple_id;
    end if;
    return NEW;
end;
$$;

create trigger trg_update_streak
    after insert on public.check_ins
    for each row execute function public.update_couple_streak();

-- ====================================================
-- Additional tables for full MVP schema
-- ====================================================

-- 1. Users profile table (linked to Supabase Auth)
create table public.users (
    id uuid primary key references auth.users(id) on delete cascade,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null,
    email varchar not null,
    display_name varchar,
    avatar_url varchar,
    couple_id uuid references public.couples(id) on delete set null,
    fcm_token varchar,
    timezone varchar default 'UTC' not null,
    premium_tier boolean default false not null
);

-- 2. Daily check‑ins (expanded from earlier version)
create table public.daily_checkins (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    user_id uuid references public.users(id) on delete cascade not null,
    couple_id uuid references public.couples(id) on delete cascade not null,
    mood_emoji varchar(10) not null,
    mood_label varchar(50) not null,
    affection_score integer check (affection_score >= 1 and affection_score <= 10) not null,
    stress_score integer check (stress_score >= 1 and stress_score <= 10) not null,
    energy_score integer check (energy_score >= 1 and energy_score <= 10) not null,
    journal_note text,
    shared_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. AI insights table
create table public.ai_insights (
    id uuid primary key default uuid_generate_v4(),
    couple_id uuid references public.couples(id) on delete cascade not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    start_date date not null,
    end_date date not null,
    summary text not null,
    relationship_trends text[] not null,
    connection_prompts text[] not null
);

-- 4. Subscriptions table
create table public.subscriptions (
    id uuid primary key default uuid_generate_v4(),
    user_id uuid references public.users(id) on delete cascade unique not null,
    stripe_customer_id varchar,
    stripe_subscription_id varchar,
    status varchar(50) not null,
    price_id varchar,
    current_period_start timestamp with time zone,
    current_period_end timestamp with time zone,
    cancel_at_period_end boolean default false not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================================
-- Indexes for performance
-- ====================================================
create index idx_users_couple_id on public.users(couple_id);
create index idx_couples_invite_code on public.couples(invite_code);
create index idx_couples_partners on public.couples(partner_a_id, partner_b_id);
create index idx_daily_checkins_couple_created on public.daily_checkins(couple_id, created_at desc);
create index idx_daily_checkins_user_date on public.daily_checkins(user_id, created_at desc);
create index idx_streaks_couple_id on public.couple_streaks(couple_id);
create index idx_insights_couple_created on public.ai_insights(couple_id, created_at desc);

-- ====================================================
-- Row Level Security (RLS) Policies
-- ====================================================
alter table public.users enable row level security;
alter table public.couples enable row level security;
alter table public.daily_checkins enable row level security;
alter table public.couple_streaks enable row level security;
alter table public.ai_insights enable row level security;
alter table public.subscriptions enable row level security;

-- Users RLS
create policy "Users can view own profile and partner" on public.users for select using (
    auth.uid() = id or couple_id in (select couple_id from public.users where id = auth.uid())
);
create policy "Users can update own profile" on public.users for update using (auth.uid() = id);

-- Couples RLS
create policy "Couples can view their record" on public.couples for select using (
    auth.uid() = partner_a_id or auth.uid() = partner_b_id
);
create policy "Couples can insert/update if participant" on public.couples for all using (
    auth.uid() = partner_a_id or auth.uid() = partner_b_id
);

-- Daily Check‑ins RLS
create policy "Users can view couple check‑ins" on public.daily_checkins for select using (
    couple_id in (select couple_id from public.users where id = auth.uid())
);
create policy "Users can insert own check‑in" on public.daily_checkins for insert with check (
    auth.uid() = user_id and couple_id in (select couple_id from public.users where id = auth.uid())
);

-- Streaks RLS
create policy "Users can view couple streaks" on public.couple_streaks for select using (
    couple_id in (select couple_id from public.users where id = auth.uid())
);

-- AI Insights RLS
create policy "Users can view couple insights" on public.ai_insights for select using (
    couple_id in (select couple_id from public.users where id = auth.uid())
);

-- Subscriptions RLS
create policy "Users can view own subscription" on public.subscriptions for select using (auth.uid() = user_id);

-- ====================================================
-- Auth user provision trigger
-- ====================================================
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id, email, display_name, avatar_url, timezone, premium_tier)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)),
    new.raw_user_meta_data->>'avatar_url',
    coalesce(new.raw_user_meta_data->>'timezone', 'UTC'),
    false
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();