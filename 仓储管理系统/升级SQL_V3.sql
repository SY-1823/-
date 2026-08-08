-- ========================================
-- 库存管理系统 V3 数据库升级
-- 请在 Supabase SQL Editor 中执行
-- ========================================

-- 1. inventory 表：新增产品编号和成本价
ALTER TABLE inventory 
ADD COLUMN IF NOT EXISTS product_code TEXT,
ADD COLUMN IF NOT EXISTS cost_price NUMERIC;

-- 2. operation_logs 表：新增单价和总价
ALTER TABLE operation_logs 
ADD COLUMN IF NOT EXISTS unit_price NUMERIC,
ADD COLUMN IF NOT EXISTS total_price NUMERIC;

-- 3. 为客户历史查询创建索引（加速按客户名查出库记录）
CREATE INDEX IF NOT EXISTS idx_logs_customer_type 
ON operation_logs(customer_name, type);

-- 验证
SELECT 'V3 升级完成' AS status;
