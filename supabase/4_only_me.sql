drop policy if exists "authenticated users can write au_listings" on au_listings;
drop policy if exists "authenticated users can update au_listings" on au_listings;
drop policy if exists "authenticated users can delete au_listings" on au_listings;

create policy "owner can add au_listings"
  on au_listings for insert
  to authenticated
  with check (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');

create policy "owner can update au_listings"
  on au_listings for update
  to authenticated
  using (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com')
  with check (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');

create policy "owner can delete au_listings"
  on au_listings for delete
  to authenticated
  using (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');

drop policy if exists "signed-in users can add au_clubs" on au_clubs;
drop policy if exists "signed-in users can update au_clubs" on au_clubs;
drop policy if exists "signed-in users can delete au_clubs" on au_clubs;

create policy "owner can add au_clubs"
  on au_clubs for insert
  to authenticated
  with check (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');

create policy "owner can update au_clubs"
  on au_clubs for update
  to authenticated
  using (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com')
  with check (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');

create policy "owner can delete au_clubs"
  on au_clubs for delete
  to authenticated
  using (lower(auth.jwt() ->> 'email') = 'russell@slicepadelclub.com');
