

use customer_behaviour;


select * from customer


/**total revenue by male and female**/

select  gender,sum(purchase_amount) as Total_reveune from customer
group by gender;

/**customer who used the discount but still spend highest than the avg amount **/
select customer_id, purchase_amount from customer
where discount_applied = 'yes' and  purchase_amount >= (select  avg(purchase_amount)from customer)



/**top 5 product with avg highest rating **/
 select top 5 item_purchased ,avg(review_rating) as rating from customer
 group by item_purchased
 order by rating desc ;


 /**avg purchase amount between express and standard shipping **/
 select shipping_type,avg(purchase_amount) as avg_amount from customer
 where shipping_type in ('Standard','Express')
 group by  shipping_type

  /**compare average and total revenue between subcribed and non - subcribed  **/

  select subscription_status,count(customer_id) as no_customer,avg(purchase_amount) as avg_revenue,sum(purchase_amount) as total_reveune  from customer
  group by subscription_status;

select * from customer

/** top 5 highest percentage of purchases with discount applied  **/
select top 5 item_purchased,count(case when discount_applied = 'yes' then 1 end) * 100.0 / count(*)
as discount_percentage from customer
group by item_purchased
order by discount_percentage desc;



/** segment customers into new ,return and loyal based on their total number  of previous purchase **/
SELECT customer_segment, COUNT(*) AS total_customers
FROM
(
SELECT 
customer_id,
CASE 
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Return'
    ELSE 'Loyal'
END AS customer_segment
FROM customer
) AS customer_groups
GROUP BY customer_segment;


/** top 3 purchased product with ecah category with each catageory  **/
select   top 3 category, item_purchased, count(customer_id) as total_orders,
row_number()over(partition by category order by count(customer_id)desc) as item_rank from customer
group by  category,item_purchased;



select top 3 category,item_purchased,sum(purchase_amount) as total_revenue  from customer
group by category,item_purchased
order by total_revenue desc;

/**customer who are previous count buyers and also like to subscribe **/

select subscription_status,count(customer_id) as repeat_buyers from customer
where previous_purchases > 5 
group by subscription_status;

/** total reveune by age group  **/

select age_group,sum(purchase_amount) as total_revenue from customer
group by age_group
order by total_revenue desc;