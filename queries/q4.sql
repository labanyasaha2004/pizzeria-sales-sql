-- Percentage contribution of each pizza type to total revenue
WITH pizza_revenue AS (
    SELECT 
        pizza_types.name,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM 
        order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    GROUP BY pizza_types.name
), total AS (
    SELECT SUM(revenue) AS total_revenue FROM pizza_revenue
)
SELECT 
    pr.name,
    ROUND(pr.revenue, 2) AS revenue,
    ROUND(100.0 * pr.revenue / t.total_revenue, 2) AS percentage_contribution
FROM 
    pizza_revenue pr, total t
ORDER BY percentage_contribution DESC;

--  Cumulative revenue generated over time
WITH daily_revenue AS (
    SELECT 
        DATE(orders.order_date) AS order_day,
        ROUND(SUM(order_details.quantity * pizzas.price), 2) AS daily_revenue
    FROM 
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY order_day
)
SELECT 
    order_day,
    daily_revenue,
    ROUND(SUM(daily_revenue) OVER (ORDER BY order_day), 2) AS cumulative_revenue
FROM 
    daily_revenue
ORDER BY 
    order_day;
    
-- Top 3 most ordered pizza types by revenue per category
WITH revenue_by_category AS (
    SELECT  
        pizza_types.category,
        pizza_types.name AS pizza_name,
        SUM(order_details.quantity * pizzas.price) AS total_revenue
    FROM  
        order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    GROUP BY pizza_types.category, pizza_types.name
),
ranked_revenue AS (
    SELECT  
        category,
        pizza_name,
        total_revenue,
        RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS revenue_rank
    FROM  
        revenue_by_category
)
SELECT  
    category,
    pizza_name,
    ROUND(total_revenue, 2) AS revenue
FROM  
    ranked_revenue
WHERE  
    revenue_rank <= 3
ORDER BY 
    category, revenue_rank;

