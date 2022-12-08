SET LINESIZE 30000;
SET PAGESIZE 50000;

-- AD-HOC Queries --
-- Q1) What are the top three most travelled routes? --

Select * 
from Fall22_S001_6_Route 
Where R_id In 
            (Select R_id 
            from Fall22_S001_6_Scheduler 
            where S_id in 
                        (Select S_id 
                        from Fall22_S001_6_Ticket 
                        Group by S_id 
                        having count (T_id)>3  
                        Order by count (T_id) DESC fetch first 3 rows only));


-- Q2) What are the least three  travelled routes? --

Select * 
from Fall22_S001_6_Route 
Where R_id In 
            (Select R_id 
            from Fall22_S001_6_Scheduler 
            where S_id in 
                        (Select S_id 
                        from Fall22_S001_6_Ticket 
                        Group by S_id  
                        Order by count (T_id) ASC fetch first 3 rows only));


-- Q3) Which zipcode has the most number of bookings from? --

Select ZipCode , count(ZipCode) as ZipCode_Count 
from Fall22_S001_6_Passenger 
Where P_id In 
            (Select Distinct P_id 
            from  Fall22_S001_6_Ticket) 
Group by ZipCode 
having count(ZipCode)>3  
order by count(ZipCode) desc fetch first 4 rows only ; 


-- Q4)List the zipcodes and the count of street addresses in that zipcode that have "797" the street address-- 

Select StreetAddress , count(StreetAddress) as StreetAddress_Count
from Fall22_S001_6_Passenger 
Where P_id In 
            (Select Distinct P_id 
            from  Fall22_S001_6_Ticket) 
Group by StreetAddress 
having StreetAddress 
Like '%797%'  
order by count(StreetAddress) DESC; 

-- Q5) Which type of bus is most preferred by passengers(AC or Non AC)? --

SELECT B.Type, COUNT(T.T_id) as count_of_ticketid
FROM Fall22_S001_6_Ticket T, Fall22_S001_6_Bus B 
WHERE B.S_id = T.S_id 
GROUP BY B.Type;


-- Q6) Which is the most preferred payment mode? --

SELECT Mode_of_Booking, COUNT(Mode_of_Booking) as Count_of_Mode_of_Booking
FROM Fall22_S001_6_Ticket 
GROUP BY Mode_of_Booking 
ORDER BY COUNT(Mode_of_Booking) DESC;


-- Q7) What was the most preferred time and day in a week where bookings were made. --

SELECT T_TIME, COUNT(T_TIME) as Count_OF_Time
FROM Fall22_S001_6_Books 
GROUP BY T_TIME 
ORDER BY COUNT(T_TIME) DESC fetch first 5 rows only;


-- Q8)  What was the aggregate results based on passenger zipcode and mode of booking--

SELECT Fall22_S001_6_Ticket.Mode_of_Booking,Fall22_S001_6_Passenger.Zipcode,Count(Fall22_S001_6_Passenger.Zipcode) as Zipcode_Count 
FROM Fall22_S001_6_Passenger INNER JOIN Fall22_S001_6_Ticket ON Fall22_S001_6_Passenger.P_id = Fall22_S001_6_Ticket.P_id 
GROUP BY CUBE (Fall22_S001_6_Passenger.Zipcode,Fall22_S001_6_Ticket.Mode_of_Booking);


-- Q9) What was the total seats left in all routes available --

SELECT R_id as Route_id, sum(Seat_Capacity) as Total_Seats_Left 
FROM Fall22_S001_6_Scheduler 
GROUP BY ROLLUP(R_id);

-- Q10)  What is the average number of tickets books from 2021-01-01 to 2021-01-31?--

SELECT T_Date,Avg(No_Of_Tickets) as Average_Tickets_Booked
FROM Fall22_S001_6_Books 
WHERE T_Date>= TO_DATE('2021-01-01','YYYY/MM/DD') AND T_Date<= TO_DATE('2021-01-31','YYYY/MM/DD') GROUP BY T_Date;


-- Q11) Business owner wants to know the details of all employees working on schedules 1-10. --

SELECT e.E_id, e.Fname, e.LName,(SELECT emp_contact.Contact FROM Fall22_S001_6_EmployeeContacts emp_contact WHERE e.E_id = emp_contact.E_id) as Employee_Contacts 
FROM Fall22_S001_6_Employee e, Fall22_S001_6_Scheduler s 
WHERE e.S_id = s.S_id AND s.S_id BETWEEN 1 AND 10;


-- Q12)  List down the routes based on the distances between then (highest to lowest range) (rank them) --

select r.*, row_number() over(order by distance DESC) as Rank 
from Fall22_S001_6_Route r;