
##UNIT 1- Selecting Columns: This section provides a brief introduction to working with relational databases. You'll learn about their 
#structure, how to talk about them using database lingo, and how to begin an analysis using simple SQL commands to select and summarize 
#columns from database tables.

#Onboarding | Tables
# Onboarding | Errors
#Try running me!

'DataCamp <3 SQL'
AS result;

#Shows Error- "syntax error at or near "'DataCamp <3 SQL'" LINE 2: 'DataCamp <3 SQL' ^"

SELECT 'DataCamp <3 SQL'
AS result;

#Onboarding | Bullet Exercises
# Instruction1- Submit the query in the editor! Don't worry, you'll learn how it works soon.

SELECT 'SQL'
AS result;

# Instruction2- Now change 'SQL' to 'SQL is' and click Submit!

SELECT 'SQL is'
AS result;

# Instruction3- Finally, change 'SQL is' to 'SQL is cool!' and click Submit!

SELECT 'SQL is cool!'
AS result;

# SELECTing single columns- While SQL can be used to create and modify databases, the focus of this course will be querying databases. A 
#query is a request for data from a database table (or combination of tables). Querying is an essential skill for a data scientist, #since the data you need for your analyses will often live in databases.

# Instruction1- Select the title column from the films table.
SELECT title
FROM films;

# Instruction2- Select the release_year column from the films table.
SELECT release_year
FROM films;

# Instruction3- Select the name of each person in the people table.

SELECT name
FROM people;

## SELECTing multiple columns

# Example: To select multiple columns from a table, simply separate the column names with commas!
#For example, this query selects two columns, name and birthdate, from the people table:

SELECT name, birthdate
FROM people;

#Sometimes, you may want to select all columns from a table. 
#Typing out every column name would be a pain, so there's a handy shortcut:

SELECT *
FROM people;

#If you only want to return a certain number of results, you can use the LIMIT keyword to limit the number of rows returned:

SELECT *
FROM people
LIMIT 10;

# Instruction 1: Get the title of every film from the films table.
SELECT title
FROM films;

# Instruction 2: Get the title and release year for every film.

SELECT title,release_year
FROM films;

# Instruction 3: Get the title, release year and country for every film.

SELECT title, release_year,country
FROM films;

# Instruction 4: Get all columns from the films table.

SELECT *
FROM films;

## SELECT DISTINCT
#Example: Often your results will include many duplicate values. If you want to select all the unique values from a column, you 
# can use the DISTINCT keyword. This might be useful if, for example, you're interested in knowing which languages are represented in 
# the films table:

SELECT DISTINCT language
FROM films;

# Instruction 1: Get all the unique countries represented in the films table.
SELECT DISTINCT country
FROM films;

# Instruction 2: Get all the different film certifications from the films table.

SELECT DISTINCT certification
FROM films;

# Instruction 3: Get the different types of film roles from the roles table.

SELECT DISTINCT role
FROM roles;

## Learning to COUNT
# Example- What if you want to count the number of employees in your employees table? The COUNT statement lets you do this by returning 
# the number of rows in one or more columns. For example, this code gives the number of rows in the people table:

SELECT COUNT(*)
FROM people;

# Practice with COUNT

# Example- As you've seen, COUNT(*) tells you how many rows are in a table. However, if you want to count the number of non-missing 
# values in a particular column, you can call COUNT on just that column. For example, to count the number of birth dates present in the 
# people table:

SELECT COUNT(birthdate)
FROM people;

#It's also common to combine COUNT with DISTINCT to count the number of distinct values in a column. For example, this query counts the 
# number of distinct birth dates contained in the people table:

SELECT COUNT(DISTINCT birthdate)
FROM people;

#Let's get some practice with COUNT!

# Instruction 1: Count the number of rows in the people table.
SELECT COUNT(*)
	FROM people;

# Instruction 2: Count the number of (non-missing) birth dates in the people table.

SELECT COUNT(birthdate)
FROM people;

# Instruction 3: Count the number of unique birth dates in the people table.

SELECT COUNT(birthdate)
FROM people;

# Instruction 4: Count the number of unique languages in the films table.

SELECT COUNT(DISTINCT language)
	FROM films;
  
# Instruction 5: Count the number of unique countries in the films table.

SELECT COUNT(DISTINCT country)
	FROM films;

## UNIT 2- FILTERING ROWS: This chapter builds on the first by teaching you how to filter tables for rows satisfying some criteria of 
#interest. You'll learn how to use basic comparison operators, combine multiple criteria, match patterns in text, and much more.

## Simple filtering of numeric values
# Example- As you learned in the previous exercise, the WHERE clause can also be used to filter numeric records, such as years or ages.
#For example, the following query selects all details for films with a budget over ten thousand dollars:

SELECT *
FROM films
WHERE budget > 10000;

# Instruction 1: Get all details for all films released in 2016.
SELECT *
FROM films
WHERE release_year=2016;

# Instruction 2: Get the number of films released before 2000.

SELECT COUNT(*)
FROM films
WHERE release_year<2000;

# Instruction 3: Get the title and release year of films released after 2000.
SELECT title, release_year
FROM films
WHERE release_year>2000;

## Simple filtering of text

#Example- Remember, the WHERE clause can also be used to filter text results, such as names or countries.For example, this query gets 
# the titles of all films which were filmed in China:

SELECT title
FROM films
WHERE country = 'China';

#Now it's your turn to practice using WHERE with text values!

# Instruction 1: Get all details for all French language films.

SELECT *
	FROM films
	WHERE language = 'French';


# Instruction 2: Get the name and birth date of the person born on November 11th, 1974. Remember to use ISO date format ('1974-11-11')!

SELECT *
	FROM people
	WHERE birthdate = '1974-11-11';

# Instruction 3: Get the number of Hindi language films.

SELECT COUNT(language)
	FROM films
	WHERE language = 'Hindi';

# Instruction 4: Get all details for all films with an R certification.

SELECT *
	FROM films
	WHERE certification = 'R';
  
  
## WHERE AND

#Example- Often, you'll want to select data based on multiple conditions. You can build up your WHERE queries by combining multiple 
#conditions with the AND keyword. For example,

SELECT title
FROM films
WHERE release_year > 1994
AND release_year < 2000;

#gives you the titles of films released between 1994 and 2000.

#Note that you need to specify the column name separately for every AND condition, so the following would be invalid:

SELECT title
FROM films
WHERE release_year > 1994 AND < 2000;

#You can add as many AND conditions as you need!

# Instruction 1: Get the title and release year for all Spanish language films released before 2000.
SELECT title, release_year
	FROM films
	WHERE language = 'Spanish' and release_year < 2000

# Instruction 2: Get all details for Spanish language films released after 2000.
SELECT *
	FROM films
	WHERE language = 'Spanish' and release_year > 2000

# Instruction 3:Get all details for Spanish language films released after 2000, but before 2010.

	SELECT *
	FROM films
	WHERE language = 'Spanish' and release_year > 2000 and release_year < 2010
  
  
## WHERE AND OR (2)

#Example- You now know how to select rows that meet some but not all conditions by combining AND and OR.For example, the following query 
# selects all films that were released in 1994 or 1995 which had a rating of PG or R.

SELECT title
FROM films
WHERE (release_year = 1994 OR release_year = 1995)
AND (certification = 'PG' OR certification = 'R');

# Instruction 1: Get the title and release year for films released in the 90s.

SELECT title, release_year
	FROM films
	WHERE release_year >= 1990 AND release_year <2000

# Instruction 2: Now, build on your query to filter the records to only include French or Spanish language films.

SELECT title, release_year
	FROM films
	WHERE release_year >= 1990 AND release_year <2000
		AND (language = 'French' OR language = 'Spanish');

# Instruction 3: Finally, restrict the query to only return films that took in more than $2M gross.

SELECT title, release_year
	FROM films
	WHERE release_year >= 1990 AND release_year <2000
		AND (language = 'French' OR language = 'Spanish')
	AND gross > 2000000;

## BETWEEN (2)
#Similar to the WHERE clause, the BETWEEN clause can be used with multiple AND and OR operators, so you can build up your queries and 
#make them even more powerful! For example, suppose we have a table called kids. We can get the names of all kids between the ages of 2 
# and 12 from the United States:

SELECT name
FROM kids
WHERE age BETWEEN 2 AND 12
AND nationality = 'USA';

# Instruction 1: Get the title and release year of all films released between 1990 and 2000 (inclusive).
SELECT title, release_year
	FROM films
	WHERE release_year BETWEEN 1990 AND 2000;

# Instruction 2: Now, build on your previous query to select only films that have budgets over $100 million.
SELECT title, release_year
	FROM films
	WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000;

# Instruction 3: Now restrict the query to only return Spanish language films.

SELECT title, release_year
	FROM films
	WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000
	AND language = 'Spanish';

# Instruction 4: Finally, modify to your previous query to include all Spanish language or French language films with the same criteria 
#as before. Don't forget your parentheses!

SELECT title, release_year
	FROM films
	WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000
	AND (language = 'Spanish' OR language = 'French');
	
## WHERE IN
#EXAMPLE: As you've seen, WHERE is very useful for filtering results. However, if you want to filter based on many conditions, WHERE can 
#get unwieldy. For example:

SELECT name
FROM kids
WHERE age = 2
OR age = 4
OR age = 6
OR age = 8
OR age = 10;

#Enter the IN operator! The IN operator allows you to specify multiple values in a WHERE clause, making it easier and quicker to specify 
#multiple OR conditions! Neat, right? So, the above example would become simply:

SELECT name
FROM kids
WHERE age IN (2, 4, 6, 8, 10);

# Instruction 1: Get the title and release year of all films released in 1990 or 2000 that were longer than two hours. Remember, 
#duration is in minutes!

SELECT title, release_year
	FROM films
	WHERE release_year IN(1990, 2000)
	AND duration > 120;

# Instruction 2: Get the title and language of all films which were in English, Spanish, or French.

SELECT title, language
	FROM films
	WHERE language IN('English', 'Spanish', 'French');
  
# Instruction 3: Get the title and certification of all films with an NC-17 or R certification.

SELECT title, certification
	FROM films
	WHERE certification IN('NC-17', 'R');

## Introduction to NULL and IS NULL

# In SQL, NULL represents a missing or unknown value. You can check for NULL values using the expression IS NULL. For example, to count 
#the number of missing birth dates in the people table:

SELECT COUNT(*)
FROM people
WHERE birthdate IS NULL;

#As you can see, IS NULL is useful when combined with WHERE to figure out what data you're missing.Sometimes, you'll want to filter out 
#missing values so you only get results which are not NULL. To do this, you can use the IS NOT NULL operator.For example, this query 
#gives the names of all people whose birth dates are not missing in the people table.

SELECT name
FROM people
WHERE birthdate IS NOT NULL;

# Instruction 1: Get the names of people who are still alive, i.e. whose death date is missing.
SELECT name, deathdate
	FROM people
	WHERE deathdate IS null;

# Instruction 2: Get the title of every film which doesn't have a budget associated with it.
SELECT title
	FROM films
	WHERE budget IS null;

# Instruction 3: Get the number of films which don't have a language associated with them.

SELECT COUNT(*)
	FROM films
	WHERE language IS NULL;
  
## LIKE and NOT LIKE

#EXAMPLE- In SQL, the LIKE operator can be used in a WHERE clause to search for a pattern in a column. To accomplish this, you use 
#something called a wildcard as a placeholder for some other values. There are two wildcards you can use with LIKE:The % wildcard will 
#match zero, one, or many characters in text. For example, the following query matches companies like 'Data', 'DataC' 'DataCamp', 
#'DataMind', and so on:

SELECT name
FROM companies
WHERE name LIKE 'Data%';
# The _ wildcard will match a single character. For example, the following query matches companies like 'DataCamp', 'DataComp', and so 
#on:

SELECT name
FROM companies
WHERE name LIKE 'DataC_mp';
You can also use the NOT LIKE operator to find records that don't match the pattern you specify.

# Got it? Let's practice!

# Instruction 1: Get the names of all people whose names begin with 'B'. The pattern you need is 'B%'.

SELECT name
	FROM people
	WHERE name LIKE 'B%';

# Instruction 2: Get the names of people whose names have 'r' as the second letter. The pattern you need is '_r%'.
SELECT name
	FROM people
	WHERE name LIKE '_r%'

# Instruction 3: Get the names of people whose names don't start with A. The pattern you need is 'A%'.
SELECT name
	FROM people
	WHERE name NOT LIKE 'A%'

## AGGREGATE FUNCTIONS

# Instruction 1: Use the SUM function to get the total duration of all films.
SELECT SUM (duration)
	FROM films;

# Instruction 2: Get the average duration of all films.
SELECT AVG (duration)
	FROM films;

# Instruction 3: Get the duration of the shortest film.

SELECT MIN (duration)
	FROM films;

# Instruction 4: Get the duration of the longest film.
SELECT MAX (duration)
	FROM films;

##Aggregate functions practice

# Instruction 1: Use the SUM function to get the total amount grossed by all films.

SELECT SUM (gross)
	FROM films

# Instruction 2: Get the average amount grossed by all films.

SELECT AVG (gross)
	FROM films

# Instruction 3: Get the amount grossed by the worst performing film.
SELECT MIN (gross)
	FROM films

# Instruction 4: Get the amount grossed by the best performing film.

SELECT MAX (gross)
	FROM films

##Combining aggregate functions with WHERE

# Instruction 1: Use the SUM function to get the total amount grossed by all films made in the year 
#2000 or later.

SELECT SUM(gross)
	FROM films
	WHERE release_year >= 2000;

# Instruction 2: Get the average amount grossed by all films whose titles start with the letter 'A'.
SELECT AVG(gross)
	FROM films
	WHERE title LIKE 'A%'

# Instruction 3: Get the amount grossed by the worst performing film in 1994.

SELECT MIN(gross)
	FROM films
	WHERE release_year = 1994;

# Instruction 4: Get the amount grossed by the best performing film between 2000 and 2012, inclusive.

SELECT MAX(gross)
	FROM films
	WHERE release_year BETWEEN 2000 AND 2012;

## A note on arithmetic
#EXAMPLE- In addition to using aggregate functions, you can perform basic arithmetic with symbols like 
#+, -, *, and /. So, for example, this gives a result of 12:

SELECT (4 * 3);
# However, the following gives a result of 1:

SELECT (4 / 3);
#What's going on here?SQL assumes that if you divide an integer by an integer, you want to get an 
#integer back. So be careful when dividing!If you want more precision when dividing, you can add 
#decimal places to your numbers. For example,

SELECT (4.0 / 3.0) 
AS result;
#gives you the result you would expect: 1.333.

# Instruction 1: Get the title and net profit (the amount a film grossed, minus its budget) for all 
#films. Alias the net profit as net_profit.

SELECT title, (gross - budget) AS net_profit
	FROM films;

# Instruction 2: Get the title and duration in hours for all films. The duration is in minutes, so 
#you'll need to divide by 60.0 to get the duration in hours. Alias the duration in hours as 
#duration_hours.

SELECT title,duration/60.0 AS duration_hours
	FROM films;

# Instruction 3: Get the average duration in hours for all films, aliased as avg_duration_hours.

SELECT AVG(duration)  / 60.0 AS avg_duration_hours
	FROM films;
  
 ## Even more aliasing

# Instruction 1: Get the percentage of people who are no longer alive. Alias the result as 
#percentage_dead. Remember to use 100.0 and not 100!

SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead
	FROM people

# Instruction 2: Get the number of years between the newest film and oldest film. Alias the result as 
#difference.

SELECT MAX(release_year) - MIN(release_year) AS difference
	FROM films
	 
# Instruction 3: Get the number of decades the films table covers. Alias the result as 
# number_of_decades. The top half of your fraction should be enclosed in parentheses.

SELECT (MAX(release_year) - MIN(release_year))/10 AS number_of_decades
	FROM films
  
## ORDER BY

#EXAMPLE- In SQL, the ORDER BY keyword is used to sort results in ascending or descending order 
#according to the values of one or more columns.By default ORDER BY will sort in ascending order. If 
#you want to sort the results in descending order, you can use the DESC keyword. For example,

SELECT title
FROM films
ORDER BY release_year DESC;
#gives you the titles of films sorted by release year, from newest to oldest

# Sorting single columns

#Instruction 1: Get the names of people from the people table, sorted alphabetically.
SELECT name
	FROM people
	ORDER BY name
  
#Instruction 2:Get the names of people, sorted by birth date.

SELECT name
	FROM people
	ORDER BY birthdate
#Instruction 3: Get the birth date and name for every person, in order of when they were born.

SELECT name, birthdate
	FROM people
	ORDER BY birthdate;

# Sorting single columns (2)

#Instruction 1:Get the title of films released in 2000 or 2012, in the order they were released.
SELECT title
	FROM films
	WHERE release_year IN (2000, 2012)
	ORDER BY release_year;
  
#Instruction 2:Get all details for all films except those released in 2015 and order them by duration.

SELECT *
	FROM films
	WHERE release_year <> 2015
	ORDER BY duration;


#Instruction 3:Get the title and gross earnings for movies which begin with the letter 'M' and order the results alphabetically.

SELECT title, gross
	FROM films
	WHERE title LIKE 'M%'
	ORDER BY title;



