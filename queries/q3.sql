-- Total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM 
    order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category order by quantity desc;


-- Distribution of orders by hour of the day

SELECT 
    HOUR(time) AS hour,
    COUNT(order_id) AS order_count
FROM 
    orders
GROUP BY HOUR(time)
ORDER BY hour;

 
-- Category-wise distribution of pizzas
SELECT 
    pizza_types.category,
    COUNT(DISTINCT pizzas.pizza_id) AS total_pizzas
FROM 
    pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category;
4. Average number of pizzas ordered per day
SELECT 
    DATE(orders.order_date) AS order_day,
    ROUND(AVG(daily_pizzas), 2) AS avg_pizzas_per_day
FROM (
    SELECT 
        orders.order_id,
        DATE(orders.order_date) AS order_day,
        SUM(order_details.quantity) AS daily_pizzas
    FROM 
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_id, order_day
) AS sub
GROUP BY order_day
ORDER BY order_day;

--  Top 3 most ordered pizza types based on revenue
SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM 
    order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;
