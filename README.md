
Vehicle Booking Database Project

  Project Overview :
This project demonstrates core SQL concepts using a vehicle booking system.
It focuses on retrieving meaningful data from relational tables such as users, vehicles, and bookings by applying different SQL techniques like JOIN, WHERE, NOT EXISTS, GROUP BY, and HAVING.
All queries are written in PostgreSQL-compatible SQL and stored in the queries.sql file.

  Database Tables Used :
users – stores customer information
vehicles – stores vehicle details
bookings – stores booking records

  Relationships:
bookings.user_id → users.id
bookings.vehicle_id → vehicles.id

  Query 1: JOIN
Requirement : Retrieve booking information along with:
Customer name
Vehicle name

Concepts Used : INNER JOIN
SQL Query solutions : 
select users.name as customer_name, vehicles.name as vehicle_name, bookings.rent_start_date as  start_date ,bookings.rent_end_date as end_date, bookings.booking_status as status
from users
inner join bookings
on users.id = bookings.user_id
inner join vehicles
on vehicles.id =bookings.vehicle_id

Explanation : 
INNER JOIN ensures only records with matching users and vehicles are returned.
This query shows who booked which vehicle.

    Query 2: EXISTS
Requirement: Find all vehicles that have never been booked.
Concepts Used: NOT EXISTS

SQL Query solutions :
SELECT *
FROM vehicles
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings
  WHERE bookings.vehicle_id = vehicles.id
);

Explanation : 
The subquery checks if a vehicle appears in the bookings table.
NOT EXISTS returns vehicles with zero bookings.

   Query 3: WHERE
Requirement : Retrieve all available vehicles of a specific type (e.g. cars).
Concepts Used : SELECT, WHERE

SQL Query solutions :
select * from vehicles
where vehicles.type = 'car' and vehicles.availability_status = 'available';

Explanation : 
Filters vehicles by type and status.
Returns only available cars.

   Query 4: GROUP BY and HAVING
Requirement : Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

Concepts Used : GROUP BY, HAVING, COUNT

SQL Query solutions :
select vehicles.name as vehicle_name, 
  count(bookings.id) as total_bookings
from bookings
join vehicles on bookings.vehicle_id = vehicles.id
group by vehicles.name
having count(bookings.id) > 2;

Explanation : 
GROUP BY groups bookings per vehicle.
COUNT calculates total bookings.
HAVING filters vehicles with more than 2 bookings.


  SQL Concepts Demonstrated : 
 *Relational joins using foreign keys
 *Filtering data with WHERE
 *Subqueries with NOT EXISTS
 *Aggregation using COUNT
 *Group-level filtering using HAVING

 Conclusion :
This project demonstrates how real-world booking systems use SQL queries to retrieve, filter, and analyze data efficiently.

GitHub Repo: 

ERD Link: https://drawsql.app/teams/mdtonmoy-khan/diagrams/vehicle-rental-system

Viva Video Link: 





