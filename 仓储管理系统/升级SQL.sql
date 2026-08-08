-- ============ 仓储管理系统 V2 升级 SQL ============
-- 在 Supabase SQL Editor 中执行（可重复执行，幂等）

-- 1. 客户表
CREATE TABLE IF NOT EXISTS customers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  country TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMP DEFAULT NOW()
);

-- 2. 供应商表
CREATE TABLE IF NOT EXISTS suppliers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  country TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMP DEFAULT NOW()
);

-- 3. 给现有表加新字段
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS supplier TEXT DEFAULT '';
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS supplier_country TEXT DEFAULT '';

ALTER TABLE operation_logs ADD COLUMN IF NOT EXISTS customer_name TEXT DEFAULT '';
ALTER TABLE operation_logs ADD COLUMN IF NOT EXISTS customer_country TEXT DEFAULT '';
ALTER TABLE operation_logs ADD COLUMN IF NOT EXISTS supplier_name TEXT DEFAULT '';

-- 4. RLS 策略
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "allow_all" ON customers;
DROP POLICY IF EXISTS "allow_all" ON suppliers;

CREATE POLICY "allow_all" ON customers FOR ALL USING (true);
CREATE POLICY "allow_all" ON suppliers FOR ALL USING (true);

-- 5. 授权 anon 角色
GRANT SELECT, INSERT, UPDATE, DELETE ON public.customers TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.suppliers TO anon;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO anon;
