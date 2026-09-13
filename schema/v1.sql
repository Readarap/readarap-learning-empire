-- ReadaRap Academy / Learning Empire v1
-- Postgres / Supabase
-- Apply in the SQL editor, then enable RLS policies at the bottom.

create extension if not exists "pgcrypto";

create type audience as enum ('k12', 'street', 'academy');

create type org_kind as enum (
  'individual',
  'family',
  'classroom',
  'school',
  'academy',
  'correspondence'
);

create type member_role as enum (
  'learner',
  'guardian',
  'teacher',
  'school_admin',
  'academy_staff',
  'super_admin'
);

create type module_kind as enum (
  'name_flo',
  'alphabet_buss_down',
  'karaoke'
);

create type content_rating as enum ('G', 'PG', 'street');

create type swap_level as enum ('50', '75', '100');

create type rapper_tier as enum ('none', 'baby', 'little', 'big');

create type take_status as enum (
  'in_progress',
  'submitted',
  'needs_review',
  'passed',
  'retry',
  'void'
);

create type assignment_status as enum (
  'draft',
  'blocked_unmodeled',
  'open',
  'closed'
);

create type plan_code as enum (
  'free_cipher',
  'readarapper',
  'family',
  'classroom',
  'school',
  'academy',
  'street_plus'
);

create type coin_reason as enum (
  'drill_complete',
  'take_passed',
  'weekly_streak',
  'teacher_bonus',
  'spend',
  'adjust'
);

create table profiles (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid unique,
  display_name text not null,
  legal_name text,
  date_of_birth date,
  grade_band text,
  home_audience audience not null default 'k12',
  is_child boolean not null default false,
  pin_hash text,
  created_at timestamptz not null default now(),
  deleted_at timestamptz
);

comment on column profiles.auth_user_id is
  'Supabase auth.users id. Null for kiosk / correspondence learners created by staff.';
comment on column profiles.is_child is
  'True when age < 13 or school-rostered minor. Child never holds a Stripe customer id.';

create table guardian_links (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references profiles(id) on delete cascade,
  guardian_id uuid not null references profiles(id) on delete cascade,
  relationship text,
  is_billing_contact boolean not null default true,
  created_at timestamptz not null default now(),
  unique (child_id, guardian_id)
);

create table consent_events (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id) on delete cascade,
  guardian_id uuid references profiles(id),
  kind text not null,
  version text not null,
  accepted boolean not null,
  ip inet,
  created_at timestamptz not null default now()
);

create table orgs (
  id uuid primary key default gen_random_uuid(),
  kind org_kind not null,
  audience audience not null,
  name text not null,
  slug text unique,
  seat_limit integer not null default 1,
  plan plan_code not null default 'free_cipher',
  stripe_customer_id text,
  stripe_subscription_id text,
  join_code text unique,
  country text default 'US',
  created_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint org_audience_kind_chk check (
    (kind in ('classroom', 'school') and audience = 'k12')
    or (kind = 'correspondence' and audience = 'academy')
    or (kind = 'academy' and audience = 'academy')
    or (kind in ('individual', 'family'))
  )
);

create table org_members (
  org_id uuid not null references orgs(id) on delete cascade,
  profile_id uuid not null references profiles(id) on delete cascade,
  role member_role not null,
  created_at timestamptz not null default now(),
  primary key (org_id, profile_id)
);

create table classrooms (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references orgs(id) on delete cascade,
  name text not null,
  grade_band text,
  teacher_id uuid not null references profiles(id),
  join_code text unique,
  seat_limit integer not null default 35,
  created_at timestamptz not null default now()
);

create table enrollments (
  classroom_id uuid not null references classrooms(id) on delete cascade,
  profile_id uuid not null references profiles(id) on delete cascade,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  primary key (classroom_id, profile_id)
);

create table tracks (
  id text primary key,
  module module_kind not null,
  title text not null,
  coach text,
  grade_band text,
  standards text[] not null default '{}',
  rating content_rating not null default 'G',
  bpm integer,
  letter text,
  audiences audience[] not null default array['k12']::audience[],
  pack text not null default 'core',
  is_published boolean not null default false,
  created_at timestamptz not null default now()
);

create table track_bars (
  id uuid primary key default gen_random_uuid(),
  track_id text not null references tracks(id) on delete cascade,
  position integer not null,
  text text not null,
  syllable_target integer not null,
  rhyme_family text,
  fact_prompt text,
  fact_answer text,
  unique (track_id, position)
);

create table teacher_models (
  teacher_id uuid not null references profiles(id) on delete cascade,
  track_id text not null references tracks(id) on delete cascade,
  take_id uuid,
  passed_at timestamptz not null default now(),
  primary key (teacher_id, track_id)
);

create table assignments (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references orgs(id) on delete cascade,
  classroom_id uuid references classrooms(id) on delete cascade,
  track_id text not null references tracks(id),
  required_level swap_level,
  status assignment_status not null default 'draft',
  due_at timestamptz,
  created_by uuid references profiles(id),
  created_at timestamptz not null default now()
);

create table takes (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references orgs(id) on delete cascade,
  profile_id uuid not null references profiles(id) on delete cascade,
  track_id text not null references tracks(id),
  assignment_id uuid references assignments(id) on delete set null,
  module module_kind not null,
  swap_level swap_level,
  input_mode text not null default 'typed',
  status take_status not null default 'in_progress',
  syllable_score numeric(5,2),
  cadence_score numeric(5,2),
  rhyme_score numeric(5,2),
  fact_score numeric(5,2),
  weighted_score numeric(5,2),
  teacher_override boolean not null default false,
  teacher_note text,
  started_at timestamptz not null default now(),
  submitted_at timestamptz,
  reviewed_at timestamptz,
  constraint takes_input_mode_chk check (input_mode in ('typed', 'tap', 'paper', 'audio'))
);

create index takes_profile_track_idx on takes (profile_id, track_id, submitted_at desc);
create index takes_org_status_idx on takes (org_id, status);

create table take_bars (
  id uuid primary key default gen_random_uuid(),
  take_id uuid not null references takes(id) on delete cascade,
  track_bar_id uuid not null references track_bars(id),
  learner_text text,
  syllable_count integer,
  tap_bpm numeric(6,2),
  rhyme_hit boolean,
  fact_correct boolean
);

create table scores (
  take_id uuid primary key references takes(id) on delete cascade,
  w_syllable numeric(3,2) not null default 0.35,
  w_cadence numeric(3,2) not null default 0.30,
  w_rhyme numeric(3,2) not null default 0.25,
  w_fact numeric(3,2) not null default 0.10,
  passed boolean not null default false,
  computed_at timestamptz not null default now()
);

create table progress_unlocks (
  profile_id uuid not null references profiles(id) on delete cascade,
  org_id uuid not null references orgs(id) on delete cascade,
  key text not null,
  tier rapper_tier,
  unlocked_at timestamptz not null default now(),
  primary key (profile_id, org_id, key)
);

create table coin_ledger (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id) on delete cascade,
  org_id uuid not null references orgs(id) on delete cascade,
  delta integer not null,
  reason coin_reason not null,
  take_id uuid references takes(id) on delete set null,
  created_at timestamptz not null default now()
);

create table events (
  id bigint generated always as identity primary key,
  org_id uuid references orgs(id) on delete cascade,
  profile_id uuid references profiles(id) on delete set null,
  name text not null,
  payload jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create index events_org_name_idx on events (org_id, name, created_at desc);

create table subscriptions (
  org_id uuid primary key references orgs(id) on delete cascade,
  stripe_customer_id text not null,
  stripe_subscription_id text,
  plan plan_code not null,
  status text not null default 'inactive',
  seat_quantity integer not null default 1,
  current_period_end timestamptz,
  updated_at timestamptz not null default now()
);

create or replace function compute_weighted_score(
  p_syllable numeric,
  p_cadence numeric,
  p_rhyme numeric,
  p_fact numeric
) returns numeric
language sql
immutable
as $$
  select round(
    coalesce(p_syllable, 0) * 0.35
    + coalesce(p_cadence, 0) * 0.30
    + coalesce(p_rhyme, 0) * 0.25
    + coalesce(p_fact, 0) * 0.10
  , 2);
$$;
