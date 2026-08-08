-- ===================================================
-- 库存管理系统 - Supabase 数据库建表 SQL（幂等版）
-- 请在 Supabase Dashboard → SQL Editor 中全选执行
-- 注意：先点顶部绿色「Connect」按钮连接数据库
-- ===================================================

-- 1. 库存表（已存在则跳过）
CREATE TABLE IF NOT EXISTS inventory (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. 分类表（已存在则跳过）
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 3. 操作日志表（已存在则跳过）
CREATE TABLE IF NOT EXISTS operation_logs (
  id SERIAL PRIMARY KEY,
  item_name TEXT NOT NULL,
  category TEXT NOT NULL,
  quantity_change INTEGER NOT NULL,
  type TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 4. 初始分类数据（已存在则跳过）
INSERT INTO categories (name) VALUES ('泵类'), ('配件')
ON CONFLICT (name) DO NOTHING;

-- 5. 启用行级安全 (RLS)
ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE operation_logs ENABLE ROW LEVEL SECURITY;

-- 6. 创建公开访问策略（先删旧策略再建，避免重复报错）
DROP POLICY IF EXISTS "allow_all" ON inventory;
DROP POLICY IF EXISTS "allow_all" ON categories;
DROP POLICY IF EXISTS "allow_all" ON operation_logs;

CREATE POLICY "allow_all" ON inventory FOR ALL USING (true);
CREATE POLICY "allow_all" ON categories FOR ALL USING (true);
CREATE POLICY "allow_all" ON operation_logs FOR ALL USING (true);
