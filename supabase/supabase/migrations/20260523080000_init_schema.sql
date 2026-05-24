-- 20260523080000_init_schema.sql
-- Core tables, indices, triggers, and recursion-free RLS policies for the LDR Emotional-Sync App

-- ====================================================
-- 1. Couples Table (Grouping mechanism for long-distance pairs)
-- ====================================================
create table public.couples (
    id            uuid      primary key default gen_random_uuid(),
    created_at    timestamp with time zone default timezone('utc'::text, now()) not null,
    invite_code   varchar(8) unique not null,
    partner_1_id  uuid      references auth.users(id) on delete set null,
    partner_2_id  uuid      references auth.users(id) on delete set null,
    is_active     boolean   default true not null
);

-- ====================================================
-- 2. Users Profiles Table (Linked to Supabase Auth)
-- ====================================================
create table public.users (
    id            uuid primary key references auth.users(id) on delete cascade,
    created_at    timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at    timestamp with time zone default timezone('utc'::text, now()) not null,
    email         varchar not null,
    display_name  varchar,
    avatar_url    varchar,
    couple_id     uuid references public.couples(id) on delete set null,
    fcm_token     varchar,
    timezone      varchar default 'UTC' not null,
    premium_tier  boolean default false not null
);

-- ====================================================
-- 3. Daily Check-ins Table
-- ====================================================
create table public.daily_checkins (
    id               uuid primary key default gen_random_uuid(),
    created_at       timestamp with time zone default timezone('utc'::text, now()) not null,
    user_id          uuid references public.users(id) on delete cascade not null,
    couple_id        uuid references public.couples(id) on delete cascade not null,
    mood_emoji       varchar(10) not null,
    mood_label       varchar(50) not null,
    affection_score  integer check (affection_score >= 1 and affection_score <= 10) not null,
    stress_score     integer check (stress_score >= 1 and stress_score <= 10) not null,
    energy_score     integer check (energy_score >= 1 and energy_score <= 10) not null,
    journal_note     text,
    shared_at        timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================================
-- 4. Streaks Table
-- ====================================================
create table public.streaks (
    id               uuid primary key default gen_random_uuid(),
    couple_id        uuid references public.couples(id) on delete cascade unique not null,
    current_streak   integer default 0 not null,
    longest_streak   integer default 0 not null,
    last_checkin_date date,
    created_at       timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at       timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================================
-- 5. AI Insights Table
-- ====================================================
create table public.ai_insights (
    id                  uuid primary key default gen_random_uuid(),
    couple_id           uuid references public.couples(id) on delete cascade not null,
    created_at          timestamp with time zone default timezone('utc'::text, now()) not null,
    start_date          date not null,
    end_date            date not null,
    summary             text not null,
    relationship_trends text[] not null,
    connection_prompts  text[] not null
);

-- ====================================================
-- 6. Subscriptions Table
-- ====================================================
create table public.subscriptions (
    id                      uuid primary key default gen_random_uuid(),
    user_id                 uuid references public.users(id) on delete cascade unique not null,
    stripe_customer_id      varchar,
    stripe_subscription_id  varchar,
    status                  varchar(50) not null,
    price_id                varchar,
    current_period_start    timestamp with time zone,
    current_period_end      timestamp with time zone,
    cancel_at_period_end    boolean default false not null,
    created_at              timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at              timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================================
-- Performance Indexes
-- ====================================================
create index idx_users_couple_id on public.users(couple_id);
create index idx_couples_invite_code on public.couples(invite_code);
create index idx_couples_partners on public.couples(partner_1_id, partner_2_id);
create index idx_checkins_couple_created on public.daily_checkins(couple_id, created_at desc);
create index idx_checkins_user_date on public.daily_checkins(user_id, created_at desc);
create unique index idx_unique_daily_checkin on public.daily_checkins(user_id, date(timezone('utc'::text, created_at)));
create index idx_streaks_couple_id on public.streaks(couple_id);
create index idx_insights_couple_created on public.ai_insights(couple_id, created_at desc);

-- ====================================================
-- Row-Level Security (RLS)
-- ====================================================
alter table public.users enable row level security;
alter table public.couples enable row level security;
alter table public.daily_checkins enable row level security;
alter table public.streaks enable row level security;
alter table public.ai_insights enable row level security;
alter table public.subscriptions enable row level security;

-- 1. Users RLS (Recursion-Free: queries public.couples, NOT public.users)
create policy "Users can view their own profile and their partner's profile in the same couple"
on public.users for select using (
    auth.uid() = id or couple_id in (
        select id from public.couples
        where partner_1_id = auth.uid() or partner_2_id = auth.uid()
    )
);

create policy "Users can update their own profile"
on public.users for update using (auth.uid() = id);

-- 2. Couples RLS
create policy "Couples can view their couple record if they belong to it"
on public.couples for select using (
    auth.uid() = partner_1_id or auth.uid() = partner_2_id
);

create policy "Couples can insert/update if they are a participant"
on public.couples for all using (
    auth.uid() = partner_1_id or auth.uid() = partner_2_id
);

-- 3. Daily Checkins RLS (Recursion-Free)
create policy "Users can view checkins of their couple"
on public.daily_checkins for select using (
    couple_id in (
        select id from public.couples
        where partner_1_id = auth.uid() or partner_2_id = auth.uid()
    )
);

create policy "Users can insert their own checkins"
on public.daily_checkins for insert with check (
    auth.uid() = user_id and couple_id in (
        select id from public.couples
        where partner_1_id = auth.uid() or partner_2_id = auth.uid()
    )
);

-- 4. Streaks RLS (Recursion-Free)
create policy "Users can view streaks of their couple"
on public.streaks for select using (
    couple_id in (
        select id from public.couples
        where partner_1_id = auth.uid() or partner_2_id = auth.uid()
    )
);

-- 5. AI Insights RLS (Recursion-Free)
create policy "Users can view AI insights of their couple"
on public.ai_insights for select using (
    couple_id in (
        select id from public.couples
        where partner_1_id = auth.uid() or partner_2_id = auth.uid()
    )
);

-- 6. Subscriptions RLS
create policy "Users can view only their own subscription"
on public.subscriptions for select using (auth.uid() = user_id);

-- ====================================================
-- Automation Triggers & Functions
-- ====================================================

-- A. Automatically provision user record upon Supabase SignUp
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

-- B. Automatically initialize streak row when a couple is formed
create or replace function public.handle_new_couple()
returns trigger as $$
begin
  insert into public.streaks (couple_id, current_streak, longest_streak, last_checkin_date)
  values (new.id, 0, 0, null)
  on conflict (couple_id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

create trigger on_couple_created
  after insert on public.couples
  for each row execute procedure public.handle_new_couple();

-- C. Keep streaks in sync upon new check-in insertion
create or replace function public.update_couple_streak()
returns trigger as $$
declare
    today date := current_date;
    yesterday date := today - interval '1 day';
    last_date date;
begin
    -- fetch the most recent check-in date for this couple before the new one
    select max(created_at)::date into last_date
      from public.daily_checkins
     where couple_id = new.couple_id
       and id <> new.id;

    if last_date is null then
        -- First check-in ever for this couple
        update public.streaks
           set current_streak = 1,
               longest_streak = greatest(longest_streak, 1),
               last_checkin_date = today,
               updated_at = now()
         where couple_id = new.couple_id;
    elsif last_date = yesterday then
        -- Continue streak
        update public.streaks
           set current_streak = current_streak + 1,
               longest_streak = greatest(longest_streak, current_streak + 1),
               last_checkin_date = today,
               updated_at = now()
         where couple_id = new.couple_id;
    elsif last_date <> today then
        -- Reset streak (missed a day)
        update public.streaks
           set current_streak = 1,
               longest_streak = greatest(longest_streak, 1),
               last_checkin_date = today,
               updated_at = now()
         where couple_id = new.couple_id;
    end if;
    return new;
end;
$$ language plpgsql security definer;

create trigger trg_update_streak
    after insert on public.daily_checkins
    for each row execute procedure public.update_couple_streak();
