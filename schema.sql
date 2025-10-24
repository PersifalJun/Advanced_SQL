CREATE SCHEMA advanced_sql;

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        product_id INT,
                        created_at TIMESTAMP NOT NULL,
                        amount NUMERIC(10,2),
                        status TEXT
);
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name TEXT,
                           email TEXT
);
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name TEXT,
                          price NUMERIC(10,2)
);


--Разбиение на партиции (Для этого orders RENAME TO orders_old , затем созданий партиций
-- и выполню INSERT всех данных в orders из orders_old)
ALTER TABLE orders RENAME TO orders_old;
CREATE TABLE orders (
                        order_id    BIGINT,
                        customer_id INT,
                        product_id  INT,
                        created_at  TIMESTAMP NOT NULL,
                        amount      NUMERIC(10,2),
                        status      TEXT,
                        PRIMARY KEY (order_id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE orders_2025_01 PARTITION OF orders
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE orders_2025_02 PARTITION OF orders
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE orders_2025_03 PARTITION OF orders
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE TABLE orders_2025_04 PARTITION OF orders
    FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');
CREATE TABLE orders_2025_05 PARTITION OF orders
    FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE orders_2025_06 PARTITION OF orders
    FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE orders_2025_07 PARTITION OF orders
    FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');
CREATE TABLE orders_2025_08 PARTITION OF orders
    FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');
CREATE TABLE orders_2025_09 PARTITION OF orders
    FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');
CREATE TABLE orders_2025_10 PARTITION OF orders
    FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');
CREATE TABLE orders_2025_11 PARTITION OF orders
    FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');
CREATE TABLE orders_2025_12 PARTITION OF orders
    FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');