# Supabase Database Setup for Tejas Elevator Engineering

This project uses **Supabase** (PostgreSQL) to store customer quote requests, elevator inquiries, and AMC maintenance requests.

## 1. Create a Free Supabase Project
1. Go to [https://supabase.com](https://supabase.com) and sign in (Free plan).
2. Click **New Project**, choose a project name (e.g. `tejas-elevator`), set a secure database password, and select your nearest region.

## 2. Initialize Database Tables
1. In your Supabase dashboard, click **SQL Editor** from the left navigation.
2. Open the file `supabase/schema.sql` in this directory, copy its entire contents, paste it into the SQL Editor, and click **Run**.
3. You will immediately see two new tables:
   - `inquiries`: Stores customer quote requests, floor requirements, and contact details.
   - `amc_requests`: Stores maintenance contracts and service audit requests.

## 3. Retrieve Your API Keys
1. In the Supabase dashboard, navigate to **Project Settings** -> **API**.
2. Copy:
   - **Project URL** (e.g., `https://xyzcompany.supabase.co`)
   - **anon / public key** (for client requests)
   - **service_role key** (for the Node.js backend server)

## 4. Add to Environment Variables
- In `backend/.env`:
  ```env
  PORT=5000
  SUPABASE_URL=https://your-project.supabase.co
  SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
  ADMIN_EMAIL=rajivkumarsethi20@gmail.com
  ADMIN_PHONE=7008176166
  ```
- In `frontend/.env.local`:
  ```env
  NEXT_PUBLIC_BACKEND_URL=http://localhost:5000
  NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
  NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
  ```

*(Note: The backend has built-in local fallback logging, so the entire website works immediately even before entering Supabase keys!)*
