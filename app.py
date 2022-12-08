import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle
import oracledb
from tabulate import tabulate
app = Flask(__name__)

p_username="rxy8648"
P_password="Qwerty78uiop"
p_dns="az6F72ldbp1.az.uta.edu/pcse1p.data.uta.edu"
p_port="1523"
con=oracledb.connect(user=p_username,password=P_password,dsn=p_dns,port=p_port)
cur=con.cursor()

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/Route_details',methods=['POST'])
def Route_details():
    query="Select * FROM Fall22_S001_6_Route"
    res=cur.execute(query)
    return render_template('index.html',Route_details = res.fetchall())

@app.route('/Count_prefered_bus',methods=['POST'])
def Count_prefered_bus():
    int_features = [str(x) for x in request.form.values()]
    int_features[0]="'"+int_features[0]+"'"
    res=cur.execute("SELECT B.Type, COUNT(T.T_id) as count_of_ticketid FROM Fall22_S001_6_Ticket T, Fall22_S001_6_Bus B WHERE B.S_id = T.S_id AND B.TYPE like "+int_features[0]+" GROUP BY B.Type")
    print("abc")
    return render_template('index.html',Count_prefered_bus=res.fetchall())
@app.route('/most_travelled_routes',methods=['POST'])
def most_travelled_routes():
    res=cur.execute("Select * from Fall22_S001_6_Route Where R_id In (Select R_id from Fall22_S001_6_Scheduler where S_id in (Select S_id from Fall22_S001_6_Ticket Group by S_id having count (T_id)>3  Order by count (T_id) DESC fetch first 3 rows only))")
    return render_template('index.html',most_travelled_routes=res.fetchall())
@app.route('/least_travelled_routes',methods=['POST'])
def least_travelled_routes():
    res=cur.execute("Select * from Fall22_S001_6_Route Where R_id In (Select R_id from Fall22_S001_6_Scheduler where S_id in (Select S_id from Fall22_S001_6_Ticket Group by S_id  Order by count (T_id) ASC fetch first 3 rows only))")
    return render_template('index.html',least_travelled_routes=res.fetchall())
@app.route('/Passenger_details',methods=['POST'])
def Passenger_details():
    int_features = [(x) for x in request.form.values()]
    query="Select * FROM Fall22_S001_6_Passenger where P_id="+int_features[0]
    res=cur.execute(query)
    return render_template('index.html',Passenger_details=res.fetchall())

@app.route('/update_distance',methods=['POST'])
def update_distance():
    int_features = [(x) for x in request.form.values()]
    query1= "SELECT * FROM Fall22_S001_6_Route WHERE R_id="+int_features[0]
    result1=cur.execute(query1).fetchall()
    query="UPDATE Fall22_S001_6_Route SET Distance="+int_features[1]+"WHERE R_id="+int_features[0]
    cur.execute(query)
    cur.execute("COMMIT")
    query1= "SELECT * FROM Fall22_S001_6_Route WHERE R_id="+int_features[0]
    result2=cur.execute(query1).fetchall()
    FINALRESULT=["","Initial",""]+result1+["","After update",""]+result2
    
    return render_template('index.html',update_distance=FINALRESULT)

@app.route('/most_bookings_zipcode',methods=['POST'])
def most_bookings_zipcode():
    res=cur.execute("Select ZipCode , count(ZipCode) as ZipCode_Count from Fall22_S001_6_Passenger Where P_id In (Select Distinct P_id from  Fall22_S001_6_Ticket) Group by ZipCode having count(ZipCode)>3  order by count(ZipCode) desc fetch first 4 rows only")
    return render_template('index.html',most_bookings_zipcode=res.fetchall())

@app.route('/zipcode_Change',methods=['POST'])
def zipcode_Change():
    
    int_features = [str(x) for x in request.form.values()]
    query1= "SELECT * FROM Fall22_S001_6_Passenger WHERE Zipcode="+int_features[0]
    result1=cur.execute(query1).fetchall()
    query="UPDATE Fall22_S001_6_Passenger SET Zipcode="+int_features[1]+"WHERE Zipcode="+int_features[0]
    res=cur.execute(query)
    cur.execute("COMMIT")
    query1= "SELECT * FROM Fall22_S001_6_Passenger WHERE Zipcode="+int_features[1]
    result2=cur.execute(query1).fetchall()
    FINALRESULT=["","Initial",""]+result1+["","After update",""]+result2
    return render_template('index.html',zipcode_Change=FINALRESULT)



@app.route('/count_Street_address',methods=['POST'])
def count_Street_address():
    int_features = [str(x) for x in request.form.values()]
    int_features[0]="'%"+int_features[0]+"%'"
    Query="Select StreetAddress , count(StreetAddress) as StreetAddress_Count from Fall22_S001_6_Passenger Where P_id In (Select Distinct P_id from  Fall22_S001_6_Ticket) Group by StreetAddress having StreetAddress Like "+int_features[0]+" order by count(StreetAddress) DESC"
    print(Query)
    res=cur.execute(Query)
    return render_template('index.html',count_Street_address=res.fetchall())

@app.route('/Update_Address',methods=['POST'])
def Update_Address():
    int_features = [str(x) for x in request.form.values()]
    query1= "SELECT * FROM Fall22_S001_6_Passenger WHERE P_id="+int_features[0]
    print(query1)
    result1=cur.execute(query1).fetchall()
    int_features[1]="'"+int_features[1]+"'"
    query="UPDATE Fall22_S001_6_Passenger SET StreetAddress="+int_features[1]+" WHERE P_id="+int_features[0]
    print(query)
    res=cur.execute(query)
    cur.execute("COMMIT")
    query1= "SELECT * FROM Fall22_S001_6_Passenger WHERE P_id="+int_features[0]
    result2=cur.execute(query1).fetchall()
    FINALRESULT=["","Initial",""]+result1+["","After update",""]+result2
    return render_template('index.html',Update_Address=FINALRESULT)




@app.route('/DELETE_TYPE_bus',methods=['POST'])
def DELETE_TYPE_bus():
    int_features = [str(x) for x in request.form.values()]
    int_features[0]="'"+int_features[0]+"'"
    query1= "SELECT * FROM Fall22_S001_6_Bus"
    result1=cur.execute(query1).fetchall()
    res=cur.execute("DELETE Fall22_S001_6_Bus WHERE Type="+int_features[0])
    cur.execute("COMMIT")
    query1= "SELECT * FROM Fall22_S001_6_Bus"
    result2=cur.execute(query1).fetchall()
    FINALRESULT=["","#######INITIAL#######",""]+result1+["","#######AFTER DELETE#######",""]+result2
    return render_template('index.html',DELETE_TYPE_bus=FINALRESULT)

@app.route('/employee_schedule',methods=['POST'])
def employee_schedule():
    int_features = [str(x) for x in request.form.values()]
    res=cur.execute("SELECT e.E_id, e.Fname, e.LName,(SELECT emp_contact.Contact FROM Fall22_S001_6_EmployeeContacts emp_contact WHERE e.E_id = emp_contact.E_id) as Employee_Contacts FROM Fall22_S001_6_Employee e, Fall22_S001_6_Scheduler s WHERE e.S_id = s.S_id AND s.S_id BETWEEN "+int_features[0]+" AND "+int_features[1])
    return render_template('index.html',employee_schedule=res.fetchall())



@app.route('/prefered_date_time',methods=['POST'])
def prefered_date_time():
    res=cur.execute("SELECT T_TIME, COUNT(T_TIME) as Count_OF_Time FROM Fall22_S001_6_Books GROUP BY T_TIME ORDER BY COUNT(T_TIME) DESC fetch first 5 rows only")
    return render_template('index.html',prefered_date_time=res.fetchall())

@app.route('/prefered_payment',methods=['POST'])
def prefered_payment():
    int_features = [(x) for x in request.form.values()]
    #print(int_features)
    query="SELECT Mode_of_Booking, COUNT(Mode_of_Booking) as Count_of_Mode_of_Booking FROM Fall22_S001_6_Ticket GROUP BY Mode_of_Booking ORDER BY COUNT(Mode_of_Booking) DESC fetch first "+int_features[0]+" rows only"
    res=cur.execute(query)
    return render_template('index.html',prefered_payment=res.fetchall())

@app.route('/aggregate_results',methods=['POST'])
def aggregate_results():
    res=cur.execute("SELECT Fall22_S001_6_Ticket.Mode_of_Booking,Fall22_S001_6_Passenger.Zipcode,Count(Fall22_S001_6_Passenger.Zipcode) as Zipcode_Count FROM Fall22_S001_6_Passenger INNER JOIN Fall22_S001_6_Ticket ON Fall22_S001_6_Passenger.P_id = Fall22_S001_6_Ticket.P_id GROUP BY CUBE (Fall22_S001_6_Passenger.Zipcode,Fall22_S001_6_Ticket.Mode_of_Booking)")
    return render_template('index.html',aggregate_results=res.fetchall())

@app.route('/total_seats_left',methods=['POST'])
def total_seats_left():
    res=cur.execute("SELECT R_id as Route_id, sum(Seat_Capacity) as Total_Seats_Left FROM Fall22_S001_6_Scheduler GROUP BY ROLLUP(R_id)")
    return render_template('index.html',total_seats_left=res.fetchall())




@app.route('/routes_distance',methods=['POST'])
def routes_distance():
    res=cur.execute("select r.*, row_number() over(order by distance DESC) as Rank from Fall22_S001_6_Route r")
    return render_template('index.html',routes_distance=res.fetchall())



if __name__ == "__main__":
    app.run(debug=True)
