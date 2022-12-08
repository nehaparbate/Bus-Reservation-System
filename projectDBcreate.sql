
-- Query to create table Fall22_S001_6_Passenger --

CREATE TABLE Fall22_S001_6_Passenger
( P_id INT PRIMARY KEY, 
Fname VARCHAR(20) NOT NULL,
Lname VARCHAR(20),
DOB Date NOT NULL,
Email VARCHAR(100) NOT NULL, 
Zipcode INT NOT NULL,
StreetAddress VARCHAR(30) NOT NULL );



-- Query to create table Fall22_S001_6_PassengerContacts --

CREATE TABLE Fall22_S001_6_PassengerContacts
( P_id INT references Fall22_S001_6_Passenger(P_id),
Contactnumber VARCHAR(100),
PRIMARY KEY(P_id,Contactnumber) );



-- Query to create table Fall22_S001_6_Route --

Create TABLE Fall22_S001_6_Route 
( R_id  INT PRIMARY KEY,  
S_point VARCHAR(25) NOT NULL,
D_point VARCHAR(25) NOT NULL, 
Distance INT  NOT NULL );



-- Query to create table Fall22_S001_6_Scheduler --

CREATE TABLE Fall22_S001_6_Scheduler 
( S_id INT PRIMARY KEY,  
S_Date DATE NOT NULL , 
S_Time VARCHAR(20) NOT NULL, 
Seat_Capacity INT NOT NULL, 
R_id INT REFERENCES Fall22_S001_6_Route(R_id) );



-- Query to create table Fall22_S001_6_Employee --

CREATE TABLE Fall22_S001_6_Employee
( E_id INT PRIMARY KEY,
Fname VARCHAR(20) NOT NULL,
Lname VARCHAR(20),
Email VARCHAR(100) NOT NULL,
S_id INT REFERENCES Fall22_S001_6_Scheduler(S_id) );



-- Query to create table Fall22_S001_6_EmployeeContacts --

CREATE TABLE Fall22_S001_6_EmployeeContacts
( E_id INT references Fall22_S001_6_Employee(E_id),
Contact VARCHAR(100),
PRIMARY KEY(E_id,Contact) );



-- Query to create table Fall22_S001_6_Ticket --

CREATE TABLE Fall22_S001_6_Ticket 
( T_id INT PRIMARY KEY , 
Mode_of_Booking Varchar(20) , 
S_id INT REFERENCES Fall22_S001_6_Scheduler(S_id) , 
P_id REFERENCES Fall22_S001_6_Passenger(P_id) );



-- Query to create table Fall22_S001_6_Bus --

Create table Fall22_S001_6_Bus 
( B_id INT PRIMARY KEY, 
Type VARCHAR(10) NOT NULL,
S_id INT REFERENCES Fall22_S001_6_Scheduler(S_id) );



-- Query to create table Fall22_S001_6_Books --

CREATE TABLE Fall22_S001_6_Books 
( T_id INT REFERENCES Fall22_S001_6_Ticket(T_id),
T_Date DATE NOT NULL , 
T_Time VARCHAR(20) NOT NULL, 
No_Of_Tickets INT NOT NULL,
PRIMARY KEY(T_id,T_Date,T_Time) );