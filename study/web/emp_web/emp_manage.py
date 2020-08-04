# -*- coding:utf-8 -*-
import cx_Oracle as oci

# employees 데이터에 직접적으로 접근하는 경우
# emps(사본) 테이블에 접근하여 진행하였음

oracle_dsn = oci.makedsn(host="localhost", port=1521, sid="xe")
conn = oci.connect(dsn=oracle_dsn, user="hr", password="hr")

#############################################################################################
# main + 기본 기능
#############################################################################################
class Employees():
    def __init__(self, employee_id, first_name, last_name, email, phone_number,
                 hire_date, job_id, salary=0, commission_pct=0,
                 manager_id=None, department_id=None):
        self.employee_id = employee_id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone_number = phone_number
        self.hire_date = hire_date
        self.job_id = job_id
        self.salary = salary
        self.commission_pct = commission_pct
        self.manager_id = manager_id
        self.department_id = department_id

    def __str__(self):
        return f"""{self.employee_id}, {self.first_name}, {self.last_name},
            {self.email}, {self.phone_number}, {self.hire_date}, {self.job_id}, 
            {self.salary}, {self.commission_pct}, {self.manager_id}, 
            {self.department_id}"""

    def to_dict(self):
        return {"employee_id": self.employee_id,
                "first_name": self.first_name,
                "last_name": self.last_name,
                "email": self.email,
                "phone_number": self.phone_number,
                "hire_date": self.hire_date,
                "job_id": self.job_id,
                "salary": self.salary,
                "commission_pct": self.commission_pct,
                "manager_id": self.manager_id,
                "department_id" : self.department_id}

#############################################################################################
# search
#############################################################################################
def getEmpCount():
    sql = "select count(*) from emps"
    cursor = conn.cursor()
    cursor.execute(sql)
    count = cursor.fetchone()
    return count

def getEmpCountD(dept_id):
    sql = "select count(*) from emps where department_id=:deptid"
    cursor = conn.cursor()
    cursor.execute(sql, {"deptid":dept_id})
    count = cursor.fetchone()
    return count

def getDeptInfoOne(dept_id):
    sql = """select department_name, department_id from departments
            where department_id = :deptid"""
    cursor = conn.cursor()
    cursor.execute(sql, {"deptid":dept_id})
    result = cursor.fetchone()
    return result

def getEmpInfo(emp_id):
    sql = """select employee_id, first_name, last_name, 
          email, phone_number, to_char(hire_date, 'YYYY-MM-DD'),
          job_id, salary, commission_pct, 
          manager_id, department_id
          from emps
          where employee_id=:emp_id"""

    cursor = conn.cursor()
    cursor.execute(sql, {"emp_id":emp_id})
    emp_info = cursor.fetchone()
    emp = Employees(*emp_info) # 튜플 언패킹해서 생성자에 전달
    return emp

def getEmpNumbyDept():
    sql = "select nvl(department_id, '0'), count(*) from employees group by department_id"
    cursor = conn.cursor()
    cursor.execute(sql)
    num_list = cursor.fetchall()
    return num_list

def getAllEmps():
    sql = "select * from emps" # 모든 사원의 모든 열 정보 조회
    cursor = conn.cursor()
    cursor.execute(sql)
    emp_list = list()
    for emp in cursor:
        emp_list.append(Employees(*emp))
    # emp_list = cursor.fetchall()
    return emp_list

def getDeptInfo():
    sql = "select department_name, department_id from departments"
    cursor = conn.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def getJobInfo():
    sql = "select job_title, job_id from jobs"
    cursor = conn.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def getManagerInfo():
    sql = """select first_name || ' ' || last_name as name, employee_id
             from emps"""
    cursor = conn.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result



#############################################################################################
# insert
#############################################################################################
def insertEmp(**kwargs):
    if kwargs["commission_pct"] >= 1.0:
        raise ValueError("보너스율은 1보다 작아야 합니다.")

    sql = """insert into emps values 
          (:employee_id, :first_name, :last_name, :email, :phone_number, 
          to_date(:hire_date, 'YYYY-MM-DD'), :job_id, :salary, :commission_pct, 
          :manager_id, :department_id)"""
    cursor = conn.cursor()
    cursor.execute(sql, {"employee_id":kwargs["employee_id"],
                         "first_name":kwargs["first_name"],
                         "last_name":kwargs["last_name"],
                         "email":kwargs["email"],
                         "phone_number":kwargs["phone_number"],
                         "hire_date":kwargs["hire_date"],
                         "job_id":kwargs["job_id"],
                         "salary":kwargs["salary"],
                         "commission_pct":kwargs["commission_pct"],
                         "manager_id":kwargs["manager_id"],
                         "department_id":kwargs["department_id"]})
    # conn.commit()

#############################################################################################
# update
#############################################################################################
def updateEmp(emp):
    if emp['commission_pct'] >= 1.0:
        raise ValueError("보너스율은 1보다 작아야 합니다. ")
    sql = """update emps set 
        first_name = :first_name, 
        last_name = :last_name, 
        email = :email, 
        phone_number = :phone_number, 
        hire_date = to_date(:hire_date, 'YYYY-MM-DD'), 
        job_id = :job_id, 
        salary = :salary, 
        commission_pct = :commission_pct, 
        manager_id = :manager_id,
        department_id = :department_id 
        where employee_id = :employee_id
        """
    cursor = conn.cursor()
    cursor.execute(sql, emp.to_dict())
    # conn.commit()

#############################################################################################
# delete
#############################################################################################
def deleteEmp(emp_id):
    sql = "delete from emps where employee_id =:employee_id"
    cursor = conn.cursor()
    cursor.execute(sql, {"employee_id":emp_id})
    # conn.commit()


