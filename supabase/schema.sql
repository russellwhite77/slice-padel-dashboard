-- Slice Padel dashboard — initial database setup
-- Run this once in Supabase: SQL Editor > New query > paste this whole file > Run

-- ============================================================
-- au_listings — property manager data (manage.html)
-- Only signed-in users (any email) can read/write this table.
-- ============================================================
create table if not exists au_listings (
  id text primary key,
  name text,
  suburb text,
  state text,
  postcode text,
  region_label text,
  size_sqm numeric,
  rent_psm numeric,
  pa text,
  parking text,
  eaves text,
  eaves_state text,
  status text,
  added date,
  url text,
  img text,
  notes text,
  owner_note text,
  liked boolean default false,
  hidden boolean default false,
  source text,
  badges jsonb,
  wm boolean default false,
  created_by text,
  updated_by text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table au_listings enable row level security;

create policy "authenticated users can read au_listings"
  on au_listings for select
  to authenticated
  using (true);

create policy "authenticated users can write au_listings"
  on au_listings for insert
  to authenticated
  with check (true);

create policy "authenticated users can update au_listings"
  on au_listings for update
  to authenticated
  using (true) with check (true);

create policy "authenticated users can delete au_listings"
  on au_listings for delete
  to authenticated
  using (true);


-- ============================================================
-- pp_sites_au — "Our Sites" map/board on the public dashboard
-- Open to anyone with the dashboard link (no sign-in).
-- ============================================================
create table if not exists pp_sites_au (
  id bigint generated always as identity primary key,
  name text,
  address text,
  lat double precision,
  lng double precision,
  status text,
  courts integer,
  notes text,
  priority integer default 3,
  updated_by text,
  updated_at timestamptz default now()
);

alter table pp_sites_au enable row level security;

create policy "anyone can read pp_sites_au"
  on pp_sites_au for select
  to anon, authenticated
  using (true);

create policy "anyone can write pp_sites_au"
  on pp_sites_au for insert
  to anon, authenticated
  with check (true);

create policy "anyone can update pp_sites_au"
  on pp_sites_au for update
  to anon, authenticated
  using (true) with check (true);

create policy "anyone can delete pp_sites_au"
  on pp_sites_au for delete
  to anon, authenticated
  using (true);


-- ============================================================
-- pp_layouts — saved planning-tool layouts, shared across visitors
-- ============================================================
create table if not exists pp_layouts (
  name text primary key,
  data jsonb,
  saved_by text,
  updated_at timestamptz default now()
);

alter table pp_layouts enable row level security;

create policy "anyone can read pp_layouts"
  on pp_layouts for select
  to anon, authenticated
  using (true);

create policy "anyone can write pp_layouts"
  on pp_layouts for insert
  to anon, authenticated
  with check (true);

create policy "anyone can update pp_layouts"
  on pp_layouts for update
  to anon, authenticated
  using (true) with check (true);

create policy "anyone can delete pp_layouts"
  on pp_layouts for delete
  to anon, authenticated
  using (true);


-- ============================================================
-- pp_site_flags — "liked / hidden" flags on dashboard site cards
-- ============================================================
create table if not exists pp_site_flags (
  region text not null,
  site_id text not null,
  liked boolean default false,
  hidden boolean default false,
  updated_at timestamptz default now(),
  primary key (region, site_id)
);

alter table pp_site_flags enable row level security;

create policy "anyone can read pp_site_flags"
  on pp_site_flags for select
  to anon, authenticated
  using (true);

create policy "anyone can write pp_site_flags"
  on pp_site_flags for insert
  to anon, authenticated
  with check (true);

create policy "anyone can update pp_site_flags"
  on pp_site_flags for update
  to anon, authenticated
  using (true) with check (true);


-- ============================================================
-- dashboard_signins — logs who opens the dashboard (write-only)
-- ============================================================
create table if not exists dashboard_signins (
  id bigint generated always as identity primary key,
  name text,
  user_agent text,
  path text,
  created_at timestamptz default now()
);

alter table dashboard_signins enable row level security;

create policy "anyone can log a signin"
  on dashboard_signins for insert
  to anon, authenticated
  with check (true);
