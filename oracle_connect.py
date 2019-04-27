import cx_Oracle

con = cx_Oracle.connect('bp209493/abc123@localhost/LABS')
print(con.version)

cur = con.cursor()
cur.execute('select * from departments order by department_id')
for result in cur:
    print(result)

cur.close()
con.close()         
