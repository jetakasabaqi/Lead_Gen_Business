from flask import Flask, render_template, request, redirect, flash, session
from mysqlconnection import connectToMySQL
from flask_bcrypt import Bcrypt 
import re
import datetime
app = Flask(__name__)
app.secret_key='secret'
bcrypt = Bcrypt(app) 
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')  
PASSWORD_REGEX = re.compile(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!#%*?&]{5,}$')
@app.route("/")
def index():
    mysql = connectToMySQL("lead_gen_business")
    query = "SELECT * FROM leads"
    get_client_and_leads_query ="SELECT CONCAT(clients.first_name,' ', clients.last_name) as name, count(leads.site_id) as leads FROM leads join sites on leads.site_id = sites.site_id join clients on sites.client_id = clients.client_id where leads.registered_datetime > '2011/01/01' and leads.registered_datetime<'2011/12/31' group by leads.site_id order by leads DESC limit 10;"
    result = mysql.query_db(get_client_and_leads_query)
    print(result)
    today = datetime.date.today()
    return render_template('index.html', cl_leads = result, start='2011-01-01', end='2011-12-31' )

@app.route('/update_chart', methods=["POST"])
def update_chart():
    print(request.form)
    mysql = connectToMySQL("lead_gen_business")
    start_date_str = request.form['start']
    start_date = datetime.datetime.strptime(start_date_str, '%Y-%m-%d')
    print('Date:', start_date.date())
    print('Time:', start_date.time())
    print('Date-time:', start_date)
    data ={
            'start': request.form['start'],
            'end': request.form['end']
        }
    get_client_and_leads_query ="SELECT CONCAT(clients.first_name,' ', clients.last_name) as name, count(leads.site_id) as leads FROM leads join sites on leads.site_id = sites.site_id join clients on sites.client_id = clients.client_id where leads.registered_datetime > %(start)s and leads.registered_datetime<%(end)s group by leads.site_id order by leads DESC limit 10;"
    result = mysql.query_db(get_client_and_leads_query,data)
    print(result)
    return render_template('index.html', cl_leads = result, start= request.form['start'], end=request.form['end'])




if __name__== "__main__":
    app.run(debug=True)