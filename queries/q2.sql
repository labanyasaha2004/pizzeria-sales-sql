	-- Retrieve total number of orders placed.
	SELECT 
		COUNT(order_id)
	FROM
		orders AS total_orders;

	-- Retrieve total revenue generated from orders placed. 	
	SELECT 
		ROUND(SUM(order_details.quantity * pizzas.price),2) AS totalsales
	FROM
		order_details
			JOIN
			pizzas ON pizzas.pizza_id = order_details.pizza_id

	-- Identify the highest-priced pizza.
	SELECT 
		pizza_types.name, pizzas.price AS highestpriced_item
	FROM
		pizza_types
			JOIN
		pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	ORDER BY pizzas.price DESC
	LIMIT 1;

	-- List the top 5 most ordered pizza types along with their quantities.
	SELECT 
		pizza_types.name, SUM(order_details.quantity) AS quan
	FROM
		pizza_types
			JOIN
		pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
			JOIN
		order_details ON order_details.pizza_id = pizzas.pizza_id
	GROUP BY pizza_types.name
	ORDER BY quan DESC
	LIMIT 5;
		
	-- Identify the most common pizza size ordered.
	SELECT 
		pizzas.size,
		COUNT(order_details.order_details_id) AS order_count
	FROM
		pizzas
			JOIN
		order_details ON pizzas.pizza_id = order_details.pizza_id
	GROUP BY pizzas.size
	ORDER BY order_count DESC
	LIMIT 1;