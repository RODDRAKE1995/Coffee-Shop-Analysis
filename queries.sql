-- Coffee Shop Sales Analysis — Maven Roasters
-- Autor: Rodrigo Arce
-- Dataset: https://www.kaggle.com/datasets/agungpambudi/trends-product-coffee-shop-sales-revenue-dataset

-- 1. Ingreso total por categoría de producto
-- Hallazgo: Café + Té concentran 66.7% del ingreso total
SELECT product_category, SUM(unit_price * transaction_qty) AS ingreso_total
FROM transactions
GROUP BY product_category
ORDER BY ingreso_total DESC;


-- 2. Ingreso por tipo de café (dentro de la categoría "Coffee")
-- Hallazgo: el espresso genera más ingreso que cualquier café de filtro
SELECT product_type, SUM(unit_price * transaction_qty) AS ingreso_total
FROM transactions
WHERE product_category = 'Coffee'
GROUP BY product_type
ORDER BY ingreso_total DESC;


-- 3. Unidades vendidas por tipo de café (para comparar contra ingreso)
-- Hallazgo: "Gourmet brewed coffee" vende más unidades que el espresso,
-- pero genera menos ingreso — volumen e ingreso no son lo mismo
SELECT product_type, SUM(transaction_qty) AS unidades_vendidas
FROM transactions
WHERE product_category = 'Coffee'
GROUP BY product_type
ORDER BY unidades_vendidas DESC;


-- 4. Ingreso total por sucursal
-- Hallazgo: las 3 sucursales tienen ingresos muy parejos (<3% de diferencia)
SELECT store_location, SUM(unit_price * transaction_qty) AS ingreso_total
FROM transactions
GROUP BY store_location
ORDER BY ingreso_total DESC;


-- 5. Ticket promedio general del negocio
-- Hallazgo: $4.69 por transacción — el negocio funciona por volumen, no por tickets grandes
SELECT AVG(unit_price * transaction_qty) AS ticket_promedio
FROM transactions;


-- 6. Ticket promedio por categoría de producto
-- Hallazgo: "Coffee beans" tiene el ticket promedio más alto (5x el de "Coffee"),
-- aunque no domina el ingreso total por venderse en menor volumen
SELECT product_category, AVG(unit_price * transaction_qty) AS ticket_promedio
FROM transactions
GROUP BY product_category
ORDER BY ticket_promedio DESC;
