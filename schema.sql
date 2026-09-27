-- ====================================================================
-- TEJAS ELEVATOR ENGINEERING - SUPABASE DATABASE SCHEMA
-- ====================================================================
-- Execute this script in your Supabase Project -> SQL Editor to initialize 
-- the database tables, indexes, and Row Level Security (RLS) policies.
-- ====================================================================

-- 1. Enable UUID Extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Create Inquiries Table (Customer Quotes & General Inquiries)
CREATE TABLE IF NOT EXISTS public.inquiries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    lift_type VARCHAR(100) DEFAULT 'Passenger Elevators',
    floors VARCHAR(50) DEFAULT 'G + 3 Floors',
    building_type VARCHAR(100),
    message TEXT,
    status VARCHAR(50) DEFAULT 'new', -- 'new', 'contacted', 'survey_scheduled', 'closed'
    assigned_to VARCHAR(100) DEFAULT 'Rajiv Kumar Sethi',
    notes TEXT
);

-- Index for fast queries
CREATE INDEX IF NOT EXISTS idx_inquiries_created_at ON public.inquiries (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_inquiries_status ON public.inquiries (status);

-- 3. Create AMC Requests Table (Annual Maintenance Contract Inquiries)
CREATE TABLE IF NOT EXISTS public.amc_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    contact_name VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    property_name VARCHAR(255) NOT NULL,
    property_address TEXT,
    current_lifts_count INTEGER DEFAULT 1,
    plan_type VARCHAR(50) DEFAULT 'Comprehensive AMC', -- 'Comprehensive AMC', 'Non-Comprehensive AMC', 'Audit'
    message TEXT,
    status VARCHAR(50) DEFAULT 'pending'
);

-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.amc_requests ENABLE ROW LEVEL SECURITY;

-- 5. Create Policies (Allow Public Insert from Website, Allow Authenticated/Admin Read)
-- Inquiries: Allow anonymous public users to submit quote requests
CREATE POLICY "Allow public insert to inquiries" 
ON public.inquiries 
FOR INSERT 
TO anon, authenticated
WITH CHECK (true);

-- Inquiries: Allow service role (Backend API) to read and update
CREATE POLICY "Allow full access to service_role" 
ON public.inquiries 
FOR ALL 
TO service_role 
USING (true) 
WITH CHECK (true);

-- AMC: Allow anonymous public insert
CREATE POLICY "Allow public insert to amc_requests" 
ON public.amc_requests 
FOR INSERT 
TO anon, authenticated
WITH CHECK (true);

-- AMC: Allow service role to manage
CREATE POLICY "Allow full access to amc_requests for service_role" 
ON public.amc_requests 
FOR ALL 
TO service_role 
USING (true) 
WITH CHECK (true);

-- Sample Data (Optional verification test)
INSERT INTO public.inquiries (full_name, phone, email, lift_type, floors, message)
VALUES 
('Apex Constructions', '9876543210', 'info@apexconstructions.com', 'Passenger Elevators', 'G + 5 Floors', 'Need 2 passenger gearless lifts for newly built apartment complex.')
ON CONFLICT DO NOTHING;
