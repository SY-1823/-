-- ============================================
-- 库存系统 V5 升级脚本：库存新增【折扣价】字段
-- 执行方式：Supabase Dashboard → SQL Editor → New query → 粘贴执行
-- 执行后：库存总览会出现"折扣价"列（在库存数量与成本价之间），入库时可填
-- ============================================

ALTER TABLE public.inventory
  ADD COLUMN discount_price numeric DEFAULT 0;

-- 说明：
-- 1. 此脚本只新增列，不动已有数据，不涉及 RLS 策略（已有授权不受影响）
-- 2. 执行完 SQL 后，再上传新版 inventory.html
-- 3. 若提示 already exists，说明之前已加过，直接忽略
