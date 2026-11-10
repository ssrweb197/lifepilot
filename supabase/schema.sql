-- LifePilot cloud sync schema
-- Run this in the SQL Editor of a NEW, dedicated Supabase project for LifePilot.
-- Do not use the BillDocs project. This creates one private data row per signed-in user.

create table if not exists public.lifepilot_user_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  app_data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.lifepilot_user_data enable row level security;

drop policy if exists "Users can read their own LifePilot data" on public.lifepilot_user_data;
create policy "Users can read their own LifePilot data"
  on public.lifepilot_user_data
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Users can insert their own LifePilot data" on public.lifepilot_user_data;
create policy "Users can insert their own LifePilot data"
  on public.lifepilot_user_data
  for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their own LifePilot data" on public.lifepilot_user_data;
create policy "Users can update their own LifePilot data"
  on public.lifepilot_user_data
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

grant select, insert, update on public.lifepilot_user_data to authenticated;
