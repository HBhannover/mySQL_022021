
#################### DATABASE ###################
#1. Create a database: ==> then refrest !!!
Create database BachTestDB1;
Create Schema BachTestDB2;

#2. Create a database with check if this data's name existed:
Create database if not exists BachTestDB1;
Create database if not exists BachTestDB3;

#3. Drop a database:
Drop database BachTestDB1;
Drop schema bachtestdb2;

################################# TABLES ################################
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
Describe Drinks;
Describe Private;

#3. Inserting data into a table with: INSERT INTO <Table-Name> VALUES(value1, value2, etc..):
Insert into Drinks Values ('Becks', 3, 'Krombacker'); # ==> standard
Insert into Drinks Values ('Gilde', 4, NULL); # ==> A data without third component
Insert into Drinks (Sum, Beers, Favorite) values(5, 'Herrenhäuser Beer', 'Krombacher'); # ==> Redefine the order

#4. Select Data from a table in a data base:
Select * from Drinks; # ==> From this database (bachtestdb2)
Select * from bach.programming; # ==> Data from an other database (bach)

#5. Retrieve Data from a table (Gọi và chỉnh sửa):
  #5.1 Retrieve Data with a alias-name:
  Select Beers Be, Sum Su, Favorite Fa From Drinks; # ==> select some Columns and change the name to a alias-name
  #5.2 Retrieve Data and change the data:
  Select Beers, Sum + 100, Favorite Fave from Drinks;


