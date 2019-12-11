#UNIT 2.1: Introduction to joins
#In this chapter, you'll be introduced to the concept of joining tables, and will explore the different ways you can enrich your queries using inner joins and self joins. 
#You'll also see how to use the case statement to split up a field into different categories.

# Inner join
#PostgreSQL was mentioned in the slides but you'll find that these joins and the material here applies to different forms of SQL as well.
#Throughout this course, you'll be working with the countries database containing information about the most populous world cities as well 
#as country-level economic data, population data, and geographic data. This countries database also contains information on languages 
#spoken in each country.You can see the different tables in this database by clicking on the tabs on the bottom right below query.sql. 
#Click through them to get a sense for the types of data that each table contains before you continue with the course! Take note of the fields that appear to be shared across the tables.
#Recall from the video the basic syntax for an INNER JOIN, here including all columns in both tables:

SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;

#You'll start off with a SELECT statement and then build up to an inner join with the cities and countries tables. Let's get to it!

#Instruction 1-Begin by selecting all columns from the cities table.
SELECT * 
FROM cities;

#Instruction 2-Inner join the cities table on the left to the countries table on the right, keeping all of the fields in both tables.
#You should match the tables on the country_code field in cities and the code field in countries.
#Do not alias your tables here or in the next step. Using cities and countries is fine for now.

SELECT * 
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

#Instruction 3- Modify the SELECT statement to keep only the name of the city, the name of the country, and the name of the region the country resides in.
#Recall from our Intro to SQL for Data Science course that you can alias fields using AS. Alias the name of the city AS city and the name of the country AS country.

SELECT cities.name AS city, countries.name AS country, region
FROM cities 
INNER JOIN countries 
ON cities.country_code = countries.code;

#Inner Join (2)
#Instead of writing the full table name, you can use table aliasing as a shortcut. For tables you also use AS to add the alias immediately after the table name with a space. Check out the aliasing of cities and countries below.
SELECT c1.name AS city, c2.name AS country
FROM cities AS c1
INNER JOIN countries AS c2
ON c1.country_code = c2.code;

#Notice that to select a field in your query that appears in multiple tables, you'll need to identify which table/table alias you're referring to by using a . in your SELECT statement.
#You'll now explore a way to get data from both the countries and economies tables to examine the inflation rate for both 2010 and 2015.
#Sometimes it's easier to write SQL code out of order: you write the SELECT statement after you've done the JOIN.

#Instruction 1- Join the tables countries (left) and economies (right) aliasing countries AS c and economies AS e. Specify the field to match the tables ON.
#From this join, SELECT: c.code, aliased as country_code. name, year, and inflation_rate, not aliased.

SELECT c.code AS country_code, c.name, e.year, e.inflation_rate
FROM countries AS c
INNER JOIN economies AS e
ON c.code = e.code;

# Inner join (3)



#Instruction 1
#Instruction 2
#Instruction 3

#Instruction 1
#Instruction 2
#Instruction 3

#Instruction 1
#Instruction 2
#Instruction 3

#Instruction 1
#Instruction 2
#Instruction 3

#Instruction 1
#Instruction 2
#Instruction 3

#Instruction 1
#Instruction 2
#Instruction 3
