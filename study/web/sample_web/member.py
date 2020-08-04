# -*- coding : utf-8 -*-
import cx_Oracle as oci

#conn = oci.connect("hr/hr@localhost:1521/xe")
oracle_dsn = oci.makedsn(host="localhost", port=1521, sid="xe")
conn = oci.connect(dsn=oracle_dsn, user="hr", password="hr")
# oracle 접속

def get_emp(employee_id):
    sql = "select first_name from employees where employee_id=:empno"
    cursor = conn.cursor()
    cursor.execute(sql, {"empno":employee_id})
    name = cursor.fetchone()
    return name




