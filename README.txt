## DATABASE-Flask-Deployment
This is a demo project to elaborate how DATABASE SQL QUERIES are deployed on production using Flask API

### Prerequisites
You must have OracleDB and Flask (for API) installed.

### Project Structure
This project has four major parts :

1. app.py - This contains Flask APIs that receives data through GUI or API calls, runs the sql queries and return the result to Flask API's.
2. templates - This folder contains the HTML template to allow user to enter all the parameters to calculate the SQL Queries.

### Running the project

1. Run app.py using below command to start Flask API on Command Prompt
```
python app.py
```
By default, flask will run on port 5000.

3. Navigate to URL http://localhost:5000


