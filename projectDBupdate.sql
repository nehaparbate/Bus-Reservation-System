
-- Query to update tables  --


UPDATE Fall22_S001_6_Route SET Distance=400 WHERE R_id=30 or R_id=13;

UPDATE Fall22_S001_6_Scheduler SET R_id=16 WHERE R_id=15;

DELETE FROM Fall22_S001_6_Route WHERE R_id=15;

INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(300,'Ravi','Kanth',TO_DATE('1997/01/15','YYYY/MM/DD'),'ravi@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(301,'Neha','Prabhate',TO_DATE('1999/01/15','YYYY/MM/DD'),'ravi@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(302,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(303,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi6@mailandftp.com',75013,'797 Silent Common'); 
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(304,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi5@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(305,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(306,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi3@mailandftp.com',75013,'797 Silent Common');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(308,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi10@mailandftp.com',75013,'797 Silent Combat');
INSERT INTO Fall22_S001_6_Passenger(P_id,Fname,Lname,DOB,Email,Zipcode,StreetAddress) VALUES(309,'yash','t',TO_DATE('1999/02/15','YYYY/MM/DD'),'ravi20@mailandftp.com',75013,'797 South Cooper');

INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(401,'ZELLE',1,300);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(402,'ZELLE',1,301);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(403,'ZELLE',1,302);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(404,'ZELLE',1,303);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(405,'ZELLE',1,304);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(406,'ZELLE',1,305);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(407,'ZELLE',1,306);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(408,'ZELLE',1,308);
INSERT INTO Fall22_S001_6_Ticket ( T_ID,MODE_OF_BOOKING,S_ID,P_ID) VALUES(409,'ZELLE',1,309);

UPDATE Fall22_S001_6_Passenger SET Zipcode=75013 WHERE Zipcode=73301;

UPDATE Fall22_S001_6_Bus B SET B.Type='AC' WHERE B.Type ='NON AC';

DELETE Fall22_S001_6_Bus WHERE Type='AC';

UPDATE Fall22_S001_6_Ticket SET Mode_of_Booking='CASHAPP' WHERE Mode_of_Booking ='GPAY';

DELETE Fall22_S001_6_Books WHERE T_id in (SELECT T_id from Fall22_S001_6_Ticket WHERE Mode_of_Booking ='CASHAPP');

DELETE Fall22_S001_6_Ticket WHERE Mode_of_Booking ='CASHAPP';