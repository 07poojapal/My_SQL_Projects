To create a table in which only valid data can be entered.
In Student Info table, I have created the table using create table Student_ Info command, keeping Student Id as persisted Primary 
key with different columns as in in Email column using CHECK constraint checked whether email is valid or not then phone no should 
have length 10 and it should contains numbers using LIKE verified and both conditions are satisfied or not checked using CHECK then 
Course_opted1,Course_opted2,Course_opted_3 columns made unique applying UNIQUE constraint together on these column and 
make sure that opted course should be within given list. R marks info table, SQL_marks_info table, Excel marks info, VBA_marks_info, 
Tableau Marks info, Python Marks info, ML marks info , Full Length marks _info table and Placement Activity Table are created using 
create table tablename command using Student Id as Foreign key referencing Student Id of Student Info table.
