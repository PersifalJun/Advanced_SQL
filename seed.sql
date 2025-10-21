-- products: 20 000 товаров
INSERT INTO advanced_sql.products(name, price)
SELECT 'Product '||gs,
       (random()*990 + 10)::numeric(10,2)   -- 10.00->1000.00
FROM generate_series(1, 20000) AS gs;

-- customers: 1 000 000 клиентов
INSERT INTO advanced_sql.customers(name, email)
SELECT 'Customer '||gs,
       'user'||gs||'@example.com'
FROM generate_series(1, 1000000) AS gs;


-- Сделать 30-40 раз batch по 1000000
INSERT INTO advanced_sql.orders (customer_id, product_id, created_at, amount, status)
SELECT
    (1 + floor(random()*1000000))::int,   -- customer_id 1->1 000 000
    (1 + floor(random()*20000))::int,     -- product_id  1->20 000
    timestamp '2025-01-01'
        + (random()* (365*24*60*60)) * interval '1 second', -- случайная дата в 2025
    (random()*990 + 10)::numeric(10,2),   -- сумма 10.00->1000.00
    (ARRAY['new','paid','shipped','cancelled','refunded'])
        [1+floor(random()*5)]
FROM generate_series(1, :BATCH) gs;