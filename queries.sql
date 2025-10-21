--Формирование проблемных запросов(без  EXPLAIN ANALYZE)
--Запрос с JOIN:
SELECT o.order_id, c.name, p.name, o.amount
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN products p ON o.product_id = p.product_id
WHERE o.created_at BETWEEN '2025-10-01' AND '2025-10-31';


--Запрос с фильтром по дате, который на данный момент вызывает SeqScan:
SELECT * FROM orders WHERE created_at >= '2025-01-01' AND created_at <'2025-02-01';




--Формирование проблемных запросов(С EXPLAIN ANALYZE)
--Запрос с JOIN:
EXPLAIN ANALYZE
SELECT o.order_id, c.name, p.name, o.amount
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN products p ON o.product_id = p.product_id
WHERE o.created_at BETWEEN '2025-10-01' AND '2025-10-31';


--Запрос с фильтром по дате, который на данный момент вызывает SeqScan:
EXPLAIN ANALYZE
SELECT * FROM orders WHERE created_at >= '2025-01-01' AND created_at <'2025-02-01';

--Создание индекса по created_at в orders
CREATE INDEX idx_orders_created_at ON orders (created_at);
CREATE INDEX idx_orders_id ON orders (order_id);

--После создания индекса запрос с JOIN работает как раньше, так как слишком большая выборка.То же
-- самое и с SELECT запросом: слишком большой диапозон. Чтобы Postgres работал с индексами, надо сузить выборку

--Долго, но я подождал (9 min)
-- INSERT INTO orders
-- SELECT * FROM orders_old;

--Удалю старую таблицу
--DROP TABLE orders_old;

--Добавлю индексы
CREATE INDEX idx_orders_created_at ON orders (created_at);
CREATE INDEX idx_orders_id ON orders (order_id);

EXPLAIN ANALYZE
SELECT * FROM orders AS o
WHERE o.created_at BETWEEN '2025-01-01' AND '2025-02-01';
--Запрос выполнялся через партицию