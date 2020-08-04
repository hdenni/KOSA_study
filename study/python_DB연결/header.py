# -*- coding: utf-8 -*-
import cx_Oracle as oracle
oracle_dsn = oracle.makedsn(host="localhost", port=1521, sid="xe")
conn = oracle.connect(dsn=oracle_dsn, user="hr", password="hr")