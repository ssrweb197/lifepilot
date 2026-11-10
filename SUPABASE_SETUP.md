# LifePilot Supabase setup

LifePilot currently stores data in the browser. This setup adds secure per-user cloud sync.

## Important
- Create a **new Supabase project dedicated to LifePilot**. Do not reuse the BillDocs project.
- Never put a Supabase service-role/secret key in website code, GitHub, or chat.
- The browser may use only the project's **Project URL** and **anon/publishable key**. Row Level Security (RLS) protects each user's row.

## Setup
1. Create a new Supabase project.
2. In Authentication > Providers, enable Email. Configure email confirmation as you prefer.
3. In SQL Editor, run the contents of `supabase/schema.sql`.
4. In Project Settings > API, copy the Project URL and the anon/publishable key.
5. Keep those two public client values ready for the LifePilot frontend configuration. Do not copy the service-role key.

## Data model
Each authenticated user gets one row in `public.lifepilot_user_data`. The app's tasks, habits, goals, routines and focus totals are stored in `app_data` (JSONB). RLS policies restrict select/insert/update to `auth.uid() = user_id`.

## Current state
The live site remains unchanged until the project URL and anon/publishable key are configured and the sign-in/cloud-sync integration is tested. Existing browser-local data should be preserved and migrated only after sign-in succeeds.
