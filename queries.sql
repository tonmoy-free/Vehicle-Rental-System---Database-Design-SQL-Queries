
-- for creating database
create database vehicle_rental_system;


-- for drop data base
drop database VehicleRentalSystem;

drop table users;

-- users table created
create table if not exists users(
  id serial primary key,
  name varchar(100),
  email varchar(100) unique not null,
  password varchar(250),
  phone_number varchar(15),
  role varchar(20) not null check(role in('admin','customer')),
  created_at timestamp default now(),
  updated_at timestamp default now()
)

  drop table users;
  drop table vehicles;
  drop table bookings;

--vehicles table created
create table if not exists vehicles(
  id serial primary key,
  name varchar(100),
  type varchar(20) not null check(type in('car','bike','truck')),
  model varchar(20),
  registration_number varchar(100) unique not null,
  rental_price int not null check(rental_price >0),
  availability_status varchar(20) not null default 'available'check(availability_status in('available','rented','maintenance')),
  created_at timestamp default now(),
  updated_at timestamp default now()
)

-- booking table created
create table bookings(
  id serial primary key,
  user_id int not null references users(id) on delete cascade,
  vehicle_id int not null references vehicles(id) on delete cascade,
  rent_start_date date not null,
  rent_end_date date not null,check (rent_end_date > rent_start_date),
  booking_status varchar(30) not null default 'pending' check (booking_status in ('pending','confirmed','completed','cancelled')),
  total_cost numeric(10,2) not null check(total_cost > 0 ),
  created_at timestamp default now(),
  updated_at timestamp default now()
)

--insert data in users table
insert into users(name, email, phone_number, role)
values('Alice','alice@example.com','1234567890','customer'),
('Bob','bob@example.com','0987654321','admin'),
('Charlie','charlie@example.com','1122334455','customer')

-- insert data in vehicles table
insert into vehicles(name, type, model, registration_number,rental_price ,availability_status)
values('Toyota Corolla','car','2022','ABC-123','50','available'),
('Honda Civic','car','2021','DEF-456','60','rented'),
('Yamaha R15','bike','2023','GHI-789','30','available'),
('Ford F-150','truck','2020','JKL-012','100','maintenance')

--insert data in bookings table
insert into bookings(
  user_id,
  vehicle_id,
  rent_start_date,
  rent_end_date,
  booking_status,
  total_cost
  )
values(1, 2, '2026-10-01', '2026-10-05', 'completed', 240.00),
(1, 2, '2026-11-01', '2026-11-03', 'completed', 120.00),
(3, 2, '2026-12-01', '2026-12-02', 'completed', 60.00),
(2, 1, '2026-12-10', '2026-12-12', 'pending', 100.00)


--Query 1: JOIN
select users.name as customer_name, vehicles.name as vehicle_name, bookings.rent_start_date as  start_date ,bookings.rent_end_date as end_date, bookings.booking_status as status
from users
inner join bookings
on users.id = bookings.user_id
inner join vehicles
on vehicles.id =bookings.vehicle_id

-- Query 2: EXISTS
SELECT *
FROM vehicles
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings
  WHERE bookings.vehicle_id = vehicles.id
);

--Query 3: WHERE
select * from vehicles
where vehicles.type = 'car' and vehicles.availability_status = 'available';

--Query 4: GROUP BY and HAVING
select vehicles.name as vehicle_name, 
  count(bookings.id) as total_bookings
from bookings
join vehicles on bookings.vehicle_id = vehicles.id
group by vehicles.name
having count(bookings.id) > 2;


