#################################################
#################### DATABASE ###################
#################################################

#1. Create a database: ==> then refresh !!!
Create database BachTestDB1;
Create Schema BachTestDB2;

#2. Create a database with check if this data's name existed:
Create database if not exists BachTestDB1;
Create database if not exists BachTestDB3;

#3. Drop a database:
Drop database BachTestDB1;
Drop schema bachtestdb2;

########################## TABLES Filtering #############################
# For Creating a Table we have to use "USE <DB-Name>" first, and then:  #
# CREATE TABLE Tablename (ColName Type(size), ColName Type(size), ...); #
#########################################################################

#1. Create Table for existed Database BachTestDB3. By Type "Integer" we dont have to define the "size":
Use BachTestDB3;
Create Table Drinks (Beers varchar(20), Sum INT, Favorite varchar(30));
Create Table Talents (Sports varchar(20), Tech INT(5), Favorite varchar(30));
Create Table travelContries (Countries varchar(20), Permanence integer(5), Favorite varchar(30));
Create Table Private (City varchar(20), Cars int(5), Favorite varchar(30));

#2. To show the info (about schema, structure) of a table we can use: DESCRIBE <Table-Name>;
Use BachTestDB3;
Describe Drinks;
Describe Private;

#3. Inserting data into a table with: INSERT INTO <Table-Name> VALUES(value1, value2, etc..):
Use BachTestDB3;
Insert into Drinks Values ('Becks', 3, 'Krombacker'); 				        # ==> standard
Insert into Drinks Values ('Gilde', 4, NULL); 						# ==> A data without third component
Insert into Drinks (Sum, Beers, Favorite) values(5, 'Herrenhäuser Beer', 'Krombacher'); # ==> Redefine the order
Insert into Drinks Values ('Gilde', 4, 'Raderberger'); 
Insert into Drinks Values ('Erdinger', 10, 'Erdinger');
Insert into bachtestdb3.drinks Values (null, 0 , NULL ); 			        # ==> Sometimes gets fail, we need to call: <Database>.<Table>
Insert into bachtestdb3.drinks Values ('Ventil', Null , nULL ); 
Insert into Drinks Values('ALibabeer', 123, 'Ventil');
Insert into Drinks Values('Juhup', 321, 'BeerAlpen');
Insert into Drinks Values('Chacha', 1000, 'AleBi');

#4. Select Data from a table in a data base:
Use BachTestDB3;
Select * from Drinks; 						# ==> From this database (bachtestdb2)
Select * from bach.programming; 			        # ==> Data from an other database (bach)

#5. Retrieve Data from a table (Gọi và chỉnh sửa):
Use BachTestDB3;
  #5.1 Retrieve Data with a alias-name:
  Select Beers Be, Sum Su, Favorite Fa From Drinks; 	        # ==> select some Columns and change the name to a alias-name
  #5.2 Retrieve Data and change the data:
  Select Beers, Sum + 100, Favorite Fave from Drinks;
  
#6. Filtering with WHERE and DISTINCT clauses:
Use BachTestDB3;
Select * from Drinks;
Select * from Drinks Where Sum > 3;
Select * from Drinks Where Sum <= 4;
Select * From Drinks Where Favorite = 'Krombacher';
Select * From Drinks Where Sum = 3;
Select * From Drinks Where Beers is NULL; 				# ==> By compare with NULL muss 'is' be used 
Select * From Drinks Where Favorite is null;
Select Distinct * From Drinks;     					# ==> Filtering unique data (Nur die Daten, die einzigartig sind) 
Select Distinct Sum From Drinks	;   					# ==> Filtering only unique data of Sum ( Nur die Sum-Data, die einzigartig sind)	

#7. Logical Operators (AND, OR, NOT)
Use BachTestDB3;
Select * from Drinks;
Select * From Drinks Where Sum = 3 AND Favorite = 'Krombacker';  	 # ==> There is No differentation between 'o' and 'ó'
Select * From Drinks Where Beers = 'Herrenhauser Beer' AND Sum = 5;      # ==> There is NO differentiation between 'a' and 'ä'
Select * From Drinks Where Beers = 'Gilde' OR Sum = 10;
Select * From Drinks Where NOT Sum = 4;

#8. Logical Operators (BETWEEN, NOT BETWEEN, IN, NOT IN):
Use BachTestDB3;
Select * from Drinks;
Select * From Drinks Where Sum Between 4 And 10; 		# ==> (Samilar: Select * From Drinks Where Sum >= 4 And Sum <= 10;)
Select * From Drinks Where Sum Not Between 4 And 10;
Select * From Drinks Where Sum IN(4, 5, 10);  			# ==> (Samilar: Select * From Drinks Where Sum = 4 OR Sum = 5, Sum = 10;)
Select * From Drinks Where Sum Not IN (4, 5, 10);

#9. Pattern Matching Operators (Wild card characters):
	##### Importent Pattern: #####
	# % ==> Many Characters      #
	# - ==> Only one character   #
        ##############################
Use BachTestDB3;
Select * from Drinks;
Select * From Drinks Where Favorite Like'K%';      # ==> It means: 'K + any characters'
Select * From Drinks Where Favorite Like '%r';     # ==> It means: 'Any characters + r at the End'
Select * From Drinks Where Favorite Like 'K%r';    # ==> It means: 'K + any characters + r at the End'
Select * From Drinks Where Favorite Like '%a%';    # ==> It means: 'Any characters + a + any characters' 
Select * From Drinks Where Beers Like '%k_';       # ==> It means: 'Any characters + k + Only one character' 
Select * From Drinks Where Beers Like '_____';     # ==> It means: 'Only 5 characters' 
Select * From Drinks Where Favorite Not Like 'K%'; # ==> It means: Take all, where NOT 'K + any characters'
Select * From Drinks Where Beers Not Like '_____'; # ==> It means: Take all, where NOT'only 5 character'

################### TABLES Altering/Modify/Changing #####################
# ALTER + ADD, DROP, MODIFY, RENAME					#
# Difference: DROP, DELETE FROM, TRUNCATE				#
#########################################################################
#0. Rename a Table:
Use BachTestDB3;
Rename Table Travelcontries to Travelcountries;

#1. ALTER + ADD, MODIFY, RENAME
Use BachTestDB3;
Select * from private;
Alter Table Private Add(Smartphones varchar(10));    # ==> Add a column with format varchar(10) to table Private.
Alter Table Private Modify Column City varchar(11);  # ==> Modify Format of a Column. 
Describe Private; 				     # ==> Show Table Private-Schema to check Formats
Alter Table Private Rename Column City to Cities;    # ==> Rename a column-name

#2. DROP, DELETE FROM, TRUNCATE ||| ROLLBACK ||| SET autocommit ||| SET SQL_SAFE_UPDATES
    #2.1 DROP ==> Clear Table-Structure + Data, can't rollback anymore
    Drop Table Talents;
    Describe Talents;
    Rollback;
    
    #2.2 TRUNCATE ==> Clear only Data of Table, can't rollback. But Table-Structure still there. 
    Insert into Travelcountries Values('Germany', '10', 'Swiss');
    Select * from Travelcountries;
    Truncate Table Travelcountries;
    Describe Travelcountries;
    Rollback;
    Select * from Travelcountries;
    
    #2.3 DELETE ==> Clear only Data of Table, allow to rollback. Table-Structure still there
    SET autocommit = 0;		  				# ==> Don't commit automatic by DELETE anymore
    SET SQL_SAFE_UPDATES = 0; 				        # ==> Allow automatic update by DELETE
    
    Insert into Travelcountries Values('Swiss', '5', 'Germany');
    Select * from Travelcountries;
    Delete From Travelcountries;
    Describe Travelcountries;
    Rollback;
    Select * from Travelcountries;
    Commit; 							# ==> To commit the change to Database, because its not automatic anymore
    
    Select * From Drinks where Favorite like 'K%';
 
################### TABLES FUNCTIONS ####################################
# STRING - Function					                #
# Numeric - Function					                #
# Date - Function					                #
# Aggregate - Function					                #
######################################################################### 

# 1: STRING-Function: UPPER(), LOWER(), LENGTH(), TRIM(), NSTR(), SUBSTR(), SUBSTRING(), CONCAT()
# Link to All Functions: https://dev.mysql.com/doc/refman/8.0/en/string-functions.html
-- 1.1: UPPER():
 Select Upper('Bach');                         # -->Result: 'BACH'
 Select Upper(Countries) from Travelcountries; # --> Result: All Countries names are capitalized 
 Select Upper(Countries) UpperName from Travelcountries; # --> Result: All Countries names are capitalized and written in column "UpperName"
 
 -- 1.2: LOWER()
 Select Lower('Bach');                         # -->Result: 'bach'
 Select Lower(Countries) from Travelcountries; # --> Result: All Countries names are written in lowercase
 Select Lower(Countries) LowerName from Travelcountries; # --> Result: All Countries names are written in lowercase in column "LowerName"
 
 -- 1.3: LENGTH()
 Select Length('Welcome');                     # --> Result: 7
 Select Length(Favorite) from Travelcountries; # --> Length of Values in Column 'Favorite'
 Select * From Travelcountries Where Length(Favorite) = 5; # --> Select all Favorite's values, where length = 5
 
 -- 1.4: TRIM():
 Select Trim('  Bach    ');                    # --> Result: 'Bach'
 Select Trim('z' from ('zzzBachzz'));          # --> Result: 'Bach'
 
 -- 1.5: NSTR():
 Select INSTR('Welcome', 'o');                 # --> Position of Character 'o' is: 5
 
 -- 1.6: SUBSTR() and SUBSTRING():
 Select SUBSTR('Welcome', 2, 3);               # --> From Character 'e' count 3 characters --> Result: 'elc'
 Select SUBSTRING('Welcome', 2, 3);            # --> From Character 'e' count 3 characters --> Result: 'elc'
 Select SUBSTR(Countries, 2, 3) From Travelcountries;
 
 -- 1.7: CONCAT():
 Select Concat('Bach', 'Deptrai');             # --> Bach + Deptrai = BachDeptrai

# 2 Numeric Functions: ABS(), SQRT(), MOD(), POWER(), TRUNCATE(), GREATEST() and LEAST()
-- 2.1: ABS():
Select ABS(-50);                              # --> 50
Select ABS(50);                               # --> 50

-- 2.2 SQRT():
Select Sqrt (25);                             # --> 5

-- 2.3: POWER():
Select Power(2, 3);                           # --> 2*2*2 = 8

-- 2.4: TRUNCATE():
Select Truncate(1234.567, 2);                 # --> 1234.56
Select Truncate(1234.567, -2);                # --> 1200
Select Truncate(1234567, -2);                 # --> 1234500

-- 2.5: GREATEST() and LEAST()
Select Greatest(100, 101, 102, 103);          # --> 103
Select Least (100, 101, 102, 103);            # --> 101

# 3. Date - Functions: CURDATE() and CURRENT_DATE(), CURTIME() and CURRENT_TIME(), NOW(), SYSDATE(), MONTH(), YEAR(), DAY()

-- 3.1: CURDATE() and CURRENT_DATE():
Select Current_date();                       # --> JJJJ-MM-DD
Select Curdate();                            # --> JJ-MM-DD

-- 3.2: CURETIME() and CURRENT_TIME():
Select Current_time();                       # --> HH:MM:SS
Select Curtime();                            # --> HH:MM:SS

-- 3.3: NOW():
Select Now();                                # --> JJJJ:MM:DD HH:MM:SS

-- 3.4: SYSDATE()
Select Sysdate();                            # --> JJJJ:MM:DD HH:MM:SS

-- 3.5: YEAR(), MONTH(), DAY()
Select YEAR('2021-03-10');                   # --> 2021
Select MONTH('2021-03-10');                  # --> 03
Select DAY('2021-03-10');                    # --> 10

Select * From Employees Where Month(Hire_Date) = "6";
Select * From Employees Where Monthname(Hire_Date) = "JUNE";

# 4. Aggregate-Functions: AVG(), SUM(), MIN(), MAX(), COUNT()
Select AVG(SALARY) From Employees;
Select SUM(SALARY) From Employees;
Select MIN(SALARY) From Employees;
Select MAX(SALARY) From Employees;
Select COUNT(*) From Employees;

################### TABLES Order of Execution ###########################
#									#	
#        WHERE >> GROUP BY >> HAVING >> ORDER BY	                #
#									#
######################################################################### 
Select * from world.city;
Select Name, count(*) from world.city group by Name;

Select CountryCode, SUM(Population) From world.city 		
	Where CountryCode <> 'AFG' And CountryCode <> 'USA'     
	group by CountryCode 									 	
	Having SUM(Population) > 20000000 
	Order By (Population) DESC;                     #-- > DESC: Order should be descending 

################################### MULTI TABLES ############################################################
# !!!Conditions: same number of Columns, similar data types, in the same order!!!!			    #	 	
# UNION :           Table1(1, 2, 3), Table2(3, 4, 5) --> UNION: (1, 2, 3, 4, 5)				    #	
# UNION ALL:        Table1(1, 2, 3), Table2(3, 4, 5) --> UNION ALL: (1, 2, 3, 3, 4, 5)	 		    #		
# FULL OUTER JOIN:  Table1(1, 2, 3), Table2(3, 4, 5) --> FULL OUTER JOIN: (1, 2, 3, 4, 5)		    #
# LEFT OUTER JOIN:  Table1(1, 2, 3), Table2(3, 4, 5) --> LEFT OUTER JOIN: (1, 2, 3)			    #	
# RIGHT OUTER JOIN: Table1(1, 2, 3), Table2(3, 4, 5) --> RIGHT OUTER JOIN: (3, 4, 5)			    #
# INNER JOIN:       Table1(1, 2, 3), Table2(3, 4, 5) --> RIGHT OUTER JOIN: (3)				    #
													    #
# INTERSECT:        Table1(1, 2, 3), Table2(3, 4, 5) --> INTERSECT: (3) --> Not in mySQL		    #	
# MINUS:	        Table1(1, 2, 3), Table2(3, 4, 5) --> MINUS T1-T2: (1, 2) --> Not in mySQL	    #	
#			        Table1(1, 2, 3), Table2(3, 4, 5) --> MINUS T2-T1: (4, 5) --> Not in mySQL   #
# INTERSECT and MINUS are not supported by mySQL, but by mySQL we have "join".				    #	
############################################################################################################ 

use bach;
create table TAB1(Num int);
create table TAB2(Num int);
insert into TAB1 values(1), (2), (3);
insert into TAB2 values(3), (4), (5);

Select NUM From TAB1 UNION Select NUM From TAB2;                   # --> (1, 2, 3, 4, 5)
Select NUM From TAB1 Union All Select NUM From TAB2;               # --> (1, 2, 3, 3, 4, 5)	
Select * From TAB1 INNER JOIN TAB2 WHERE TAB1.NUM = TAB2.NUM; 	   # --> (3) Here can "ON" instead of "WHERE" be used
Select * From TAB1 LEFT OUTER JOIN TAB2 ON TAB1.NUM = TAB2.NUM;    # --> (1, 2, 3) (3)
Select * From TAB1 RIGHT OUTER JOIN TAB2 ON TAB1.NUM = TAB2.NUM;   # --> (3) (3, 4, 5)

-- Select * From TAB1 FULL JOIN TAB2 ON TAB1.NUM = TAB2.NUM        # isn't supported in mySQL
-- Select NUM From TAB1 INTERSECT Select NUM From TAB2;            # isn't supported in mySQL
-- Select NUM From TAB1 MINUS Select NUM From TAB2;                # isn't supported in mySQL
-- Select NUM From TAB2 MINUS Select NUM From TAB1;                # isn't supported in mySQL

################################### SUB-Queries ##########################################
# Sub-Query is a Query within an other Query						 #
# A--> Single Row Sub-Queries: =, >=, <=, !=   ==> Result: only one row			 #
# B--> Multi Rows Sub-Queries: IN, ANY, ALL    ==> Result: multi rows			 #
########################################################################################## 
Select *From sakila.customer;

# A--> Single Sub-Queries: =, >=, <=, !=
   #1. Scenario: Take all first_name of people whose has address_id < address_id of 'LINDA'
   Select first_name From sakila.customer Where customer.address_id < (Select customer.address_id From sakila.customer Where customer.first_name ='LINDA');

   #2. Scenario: Take first_name of people whose has greatest address_id
   Select customer.first_name From sakila.customer Where customer.customer_id = (Select Max(customer.customer_id) From sakila.customer);                 # --> AUSTIN

   #3. Scenario: Take first_name of people whose has 2nd max customer_id
   Select customer.first_name From sakila.customer Where customer.customer_id = 
	   (Select Max(customer.customer_id) From sakila.customer Where customer.customer_id < (Select Max(customer.customer_id) From sakila.customer)); # --> WADE
       
# B--> Multi Sub-Queries: IN, ANY, ALL
    #1. IN:
    Select * From sakila.payment Where rental_id IN (Select rental_id From sakila.payment Where amount = 4.99);
    
    #2. ANY:
    Select Max(payment.rental_id) From sakila.payment; 								    # --> 16049
    Select Max(payment.rental_id) From sakila.payment Where amount = 4.99; 					    # --> 16032
    Select * From sakila.payment Where rental_id < ANY (Select rental_id From sakila.payment Where amount = 4.99);  # --> every rows with rental_id < 16032
    
    #3. ALL
    Select Min(payment.rental_id) From sakila.payment; 							            # --> 1
    Select Min(payment.rental_id) From sakila.payment Where amount = 4.99; 					    # --> 4
    Select * From sakila.payment Where rental_id < ALL (Select rental_id From sakila.payment Where amount = 4.99);  # --> every rows with rental_id < 4


