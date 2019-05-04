import cx_Oracle

con = cx_Oracle.connect('bp209493/abc123@localhost/LABS')
print(con.version)

cur = con.cursor()
res = cur.execute(""" select * from Teams order by Teams.Team_ID""")
print(res)
for result in cur:
    print(result)

cur.close()
con.close()         
