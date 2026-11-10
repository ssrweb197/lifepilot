# LifePilot Supabase setup

LifePilot's frontend now includes Supabase email sign-in/sign-up and per-user cloud sync.

## 1. Dedicated project
Use the separate Supabase project named **LifePilot**. Do not use the BillDocs project.

## 2. Create the cloud table and access policies
1. Open this LifePilot project in Supabase.
2. Open **SQL Editor** → **New query**.
3. Open `supabase/schema.sql` in this GitHub repository, copy the complete SQL, paste it into the SQL Editor, and click **Run**.
4. Confirm that `public.lifepilot_user_data` exists.

The table has Row Level Security (RLS) enabled. Policies limit each authenticated user to their own row (`auth.uid() = user_id`). Do not disable RLS.

## 3. Configure email authentication
1. Open **Authentication → Providers** and make sure **Email** is enabled.
2. Open **Authentication → URL Configuration**.
3. Set the Site URL to `https://lifepilot-bw3.pages.dev`.
4. Add `https://lifepilot-bw3.pages.dev/**` to the Redirect URLs allow list (or the equivalent exact URL pattern accepted by the dashboard).
5. Choose whether to require email confirmation. If enabled, users must confirm their email before signing in.

## 4. Frontend keys and security
The LifePilot frontend is configured with the project's URL and the Supabase **publishable** key. These are browser-safe client values when RLS is correctly enabled.

**Never put a service-role key, secret key, database password, or Postgres connection string in frontend code, GitHub, or a public repository.**

## 5. Test sign-in and sync
1. Wait for the Cloudflare Pages deployment after the latest GitHub commit.
2. Open `https://lifepilot-bw3.pages.dev`.
3. Create an account with an email address and password.
4. If email confirmation is enabled, confirm the email, then sign in.
5. Add a test task, then refresh the page and check that it remains.
6. Sign in with the same account on another device to verify cloud sync.

## Data safety
- Before sign-in, existing tasks/habits/goals/routines/focus data remains in that browser's local storage.
- On first sign-in, local and cloud lists are merged by item ID and uploaded to that user's row. Habit check-in dates are combined; focus totals use the larger value to avoid losing progress.
- Cloud sync requires the SQL in `supabase/schema.sql` to be run successfully first.
- Never run this SQL in the BillDocs project.
