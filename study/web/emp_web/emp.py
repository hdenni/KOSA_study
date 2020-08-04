# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, redirect
import emp_manage as em

app = Flask(__name__)

#############################################################################################
# main + 기본 function
#############################################################################################
@app.route('/')
def home():
    emps = em.getAllEmps()
    return render_template("hr/list.html", data=emps)

@app.route('/charts')
def empChart():
    num_list = em.getEmpNumbyDept()

    chart_data = []
    for row in num_list:
        chart_data.append(f"{{from: {row[0]} , to: {row[0]}, value: {row[1]} }}")

    print(','.join(chart_data))
    return render_template("hr/chart.html", data=','.join(chart_data))

@app.route('/hr/emp_count')
@app.route('/hr/count')
@app.route('/hr/cnt')
def getEmpCount():
    result = em.getEmpCount()
    return render_template("hr/count.html", data=result[0], type="emp")

# http://localhost:5000/hr/cnt?deptid=50
# http://localhost:5000/hr/cnt/50
@app.route('/hr/cnt/<dept_id>')
def getDeptInfo(dept_id):
    dcount = em.getEmpCountD(dept_id)
    dinfo = em.getDeptInfoOne(dept_id)
    return render_template("hr/count.html", data=dcount[0],
                           dinfo={'dept_name':dinfo[0], 'dept_id':dinfo[1]},
                            type="dept")

# http://localhost:5000/hr/emp/103
@app.route('/hr/emp/<emp_id>')
def getEmpInfo(emp_id):
    emp=em.getEmpInfo(emp_id)
    return render_template('hr/view.html', data=emp.to_dict())

@app.route('/hr')
def empList():
    emps = em.getAllEmps()
    return render_template("hr/list.html", data=emps)

#############################################################################################
# insert
#############################################################################################

@app.route("/hr/insert", methods=["GET"])
def insertForm():
    dept_list = em.getDeptInfo()
    job_list = em.getJobInfo()
    manager_list = em.getManagerInfo()

    return render_template("hr/insert_form.html",
                           data = {"dept_list":dept_list,
                                   "job_list":job_list,
                                   "manager_list":manager_list})

@app.route("/hr/insert", methods=["POST"])
def insertEmp():
    employee_id = int(request.form["employee_id"])
    first_name = request.form["first_name"]
    last_name = request.form["last_name"]
    email = request.form["email"]
    phone_number = request.form["phone_number"]
    hire_date = request.form["hire_date"]
    job_id = request.form["job_id"]
    salary = int(eval(request.form["salary"]))
    commission_pct = float(request.form["commission_pct"])
    manager_id = int(request.form["manager_id"])
    department_id = int(request.form["department_id"])
    em.insertEmp(employee_id=employee_id, first_name=first_name, last_name=last_name,
                  email=email, phone_number=phone_number, hire_date=hire_date, job_id=job_id,
                  salary=salary, commission_pct=commission_pct, manager_id=manager_id,
                  department_id=department_id)
    return redirect('/hr')

#############################################################################################
# update
#############################################################################################
@app.route("/hr/update/<int:emp_id>", methods=["GET"])
def updateForm(emp_id):
    dept_list = em.getDeptInfo()
    job_list = em.getJobInfo()
    manager_list = em.getManagerInfo()
    emp = em.getEmpInfo(emp_id)

    return render_template("hr/update_form.html",
                           data={"dept_list": dept_list,
                                 "job_list": job_list,
                                 "manager_list": manager_list},
                           emp=emp.to_dict())

@app.route('/hr/update', methods=["POST"])
def updateEmp():
    employee_id = int(request.form["employee_id"])
    first_name = request.form["first_name"]
    last_name = request.form["last_name"]
    email = request.form["email"]
    phone = request.form["phone_number"]
    hire_date = request.form["hire_date"]
    job_id = request.form["job_id"]
    salary = int(eval(request.form["salary"]))
    commission_pct = float(request.form["commission_pct"])
    manager_id = int(request.form["manager_id"])
    department_id = int(request.form["department_id"])
    em.updateEmp(em.Employees(employee_id, first_name, last_name, email,
                       phone, hire_date, job_id, salary, commission_pct,
                       manager_id, department_id))
    return redirect('/hr')

#############################################################################################
# delete
#############################################################################################
@app.route("/hr/delete/<emp_id>")
def deleteEmp(emp_id):
    em.deleteEmp(emp_id)
    return redirect('/hr')


#############################################################################################
# main
#############################################################################################
if __name__=="__main__":
    app.debug = True
    app.run()
