-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT first_name, last_name, address, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

SELECT payment_id, amount, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount ASC;

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT first_name, last_name
FROM customer
WHERE (
    SELECT SUM(amount)
    FROM payment
    WHERE payment.customer_id = customer.customer_id
) > 175;

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT COUNT(customer_id), first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal'
GROUP BY first_name, last_name, country;

-- 5. Which staff member had the most
-- transactions?

-- SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(rental_id) AS Occurences
-- FROM rental
-- INNER JOIN staff
-- ON rental.staff_id = staff.staff_id
-- GROUP BY staff.staff_id, staff.first_name, staff.last_name
-- ORDER BY Occurences DESC;

SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(payment_id) AS Occurences
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id, staff.first_name, staff.last_name
ORDER BY Occurences DESC;

-- 6. How many movies of each rating are
-- there?

SELECT rating, COUNT(*) AS movie_count
FROM film
GROUP BY rating
ORDER BY movie_count DESC;

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer.customer_id IN (
    SELECT payment.customer_id
    FROM payment
    WHERE payment.amount > 6.99
    GROUP BY payment.customer_id
    HAVING COUNT(payment.payment_id) = 1
);

-- 8. How many free rentals did our stores give away?

SELECT amount, COUNT(*) AS free_rentals
FROM payment
WHERE amount = 0
GROUP BY amount
ORDER BY free_rentals;