
#################### DATABASE ###################
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
    





  


