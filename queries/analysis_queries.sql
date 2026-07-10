-- ============================================================
-- Project 3: SQL Data Analysis | DecodeLabs Industrial Training
-- Analysis Queries: SELECT, WHERE, ORDER BY, GROUP BY, HAVING,
-- and aggregations (COUNT, SUM, AVG)
-- ============================================================

-- 1. Basic SELECT: list all products with price above 1000
SELECT product_name, category, price
FROM products
WHERE price > 1000
ORDER BY price DESC;

-- 2. WHERE with equality: all orders that were Cancelled
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE status = 'Cancelled';

-- 3. WHERE with pattern matching: customers based in Delhi
SELECT customer_name, city
FROM customers
WHERE city LIKE 'Delhi%';

-- 4. ORDER BY: most recent orders first
SELECT order_id, order_date, status
FROM orders
ORDER BY order_date DESC;

-- 5. COUNT: total number of orders per status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

-- 6. SUM: total quantity sold per product
SELECT p.product_name, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;

-- 7. AVG: average order value per customer (Delivered orders only)
SELECT c.customer_name,
       ROUND(AVG(oi.quantity * p.price), 2) AS avg_item_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_name
ORDER BY avg_item_value DESC;

-- 8. GROUP BY + HAVING: product categories with more than 50 units sold
SELECT p.category, SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
HAVING SUM(oi.quantity) > 50
ORDER BY units_sold DESC;

-- 9. Revenue analysis: total revenue generated per product category
SELECT p.category,
       SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 10. Percentage contribution: each category's share of total revenue
SELECT p.category,
       SUM(oi.quantity * p.price) AS category_revenue,
       ROUND(
         100.0 * SUM(oi.quantity * p.price) /
         (SELECT SUM(oi2.quantity * p2.price)
          FROM order_items oi2
          JOIN products p2 ON oi2.product_id = p2.product_id
          JOIN orders o2 ON oi2.order_id = o2.order_id
          WHERE o2.status = 'Delivered'), 2
       ) AS pct_of_total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY pct_of_total_revenue DESC;

-- 11. Top 5 customers by number of orders placed
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY order_count DESC
LIMIT 5;

-- 12. Monthly order trend
SELECT strftime('%Y-%m', order_date) AS order_month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;
