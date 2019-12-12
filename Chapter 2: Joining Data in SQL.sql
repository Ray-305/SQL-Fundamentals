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

#The ability to combine multiple joins in a single query is a powerful feature of SQL, e.g:

SELECT *
FROM left_table
  INNER JOIN right_table
    ON left_table.id = right_table.id
  INNER JOIN another_table
    ON left_table.id = another_table.id;
#As you can see here it becomes tedious to continually write long table names in joins. 
#This is when it becomes useful to alias each table using the first letter of its name (e.g. countries AS c)! 
#It is standard practice to alias in this way and, if you choose to alias tables or are asked to specifically for an exercise in this course, you should follow this protocol.
#Now, for each country, you want to get the country name, its region, and the fertility rate and unemployment rate for both 2010 and 2015.
#Note that results should work throughout this course with or without table aliasing unless specified differently.

#Instruction 1-
#Inner join countries (left) and populations (right) on the code and country_code fields respectively.
#Alias countries AS c and populations AS p.
#Select code, name, and region from countries and also select year and fertility_rate from populations (5 fields in total).

-- 4. Select fields
SELECT c.code, name, region, year, fertility_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join with populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code;

#Instruction 2- Add an additional inner join with economies to your previous query by joining on code.
#Include the unemployment_rate column that became available through joining with economies.
#Note that year appears in both populations and economies, so you have to explicitly use e.year instead of year as you did before.


-- 6. Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code
    ON c.code = e.code;

#Instruction 3- Scroll down the query result and take a look at the results for Albania from your previous query. Does something seem off to you?
#The trouble with doing your last join on c.code = e.code and not also including year is that e.g. the 2010 value for fertility_rate is also paired with the 2015 value for unemployment_rate.
#Fix your previous query: in your last ON clause, use AND to add an additional joining condition. In addition to joining on code in c and e, also join on year in e and p.

-- 6. Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code and year
    ON c.code = e.code AND e.year = p.year;

#Inner join with using
#When joining tables with a common field name, e.g.

SELECT *
FROM countries
  INNER JOIN economies
    ON countries.code = economies.code
You can use USING as a shortcut:

SELECT *
FROM countries
  INNER JOIN economies
    USING(code)
You'll now explore how this can be done with the countries and languages tables.

#Instruction 1- Inner join countries on the left and languages on the right with USING(code).
#Select the fields corresponding to:
#country name AS country,
#continent name,language name AS language, and
#whether or not the language is official.
#Remember to alias your tables using the first letter of their names.

SELECT c.name AS country, continent, l.name AS language, l.official
FROM countries AS c
INNER JOIN languages AS l
USING (code);

#SELF JOINS
#In this exercise, you'll use the populations table to perform a self-join to calculate the percentage increase in population from 2010 to 2015 for each country code!
#Since you'll be joining the populations table to itself, you can alias populations as p1 and also populations as p2. This is good practice whenever you are aliasing and your tables have the same first letter. Note that you are required to alias the tables with self-joins.

#Instruction 1- Join populations with itself ON country_code.
#Select the country_code from p1 and the size field from both p1 and p2. SQL won't allow same-named fields, so alias p1.size as size2010 and p2.size as size2015.

SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code;

#Instruction 2- Notice from the result that for each country_code you have four entries laying out all combinations of 2010 and 2015.
#Extend the ON in your query to include only those records where the p1.year (2010) matches with p2.year - 5 (2015 - 5 = 2010). This will omit the three entries per country_code that you aren't interested in.
SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code
AND p1.year = p2.year - 5;

#Instruction 3-As you just saw, you can also use SQL to calculate values like p2.year - 5 for you. With two fields like size2010 and size2015, you may want to determine the percentage increase from one field to the next:
#With two numeric fields A and B, the percentage growth from A to B can be calculated as (B−A)/A∗100.0.
#Add a new field to SELECT, aliased as growth_perc, that calculates the percentage population growth from 2010 to 2015 for each country, using p2.size and p1.size.

SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015,
       ((p2.size - p1.size) / p1.size * 100.0) AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code
AND p1.year = p2.year - 5;

#CASE WHEN AND THEN
#Often it's useful to look at a numerical field not as raw data, but instead as being in different categories or groups.
#You can use CASE with WHEN, THEN, ELSE, and END to define a new grouping field.

#Instruction 1- Using the countries table, create a new field AS geosize_group that groups the countries into three groups:
#If surface_area is greater than 2 million, geosize_group is 'large'.
#If surface_area is greater than 350 thousand but not larger than 2 million, geosize_group is 'medium'.
#Otherwise, geosize_group is 'small'.

SELECT name, continent, code, surface_area,
    -- first case
    CASE WHEN surface_area > 2000000
    -- first then
            THEN 'large'
    -- second case
       WHEN surface_area > 350000
       -- second then
            THEN 'medium'
    -- else clause + end
       ELSE 'small' END 
    -- alias resulting field of CASE WHEN
       AS geosize_group
-- from the countries table
FROM countries;

#Inner challenge
#The table you created with the added geosize_group field has been loaded for you here with the name countries_plus. Observe the use of (and the placement of) the INTO command to create this countries_plus table:

SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
            THEN 'large'
       WHEN surface_area > 350000
            THEN 'medium'
       ELSE 'small' END
       AS geosize_group
INTO countries_plus
FROM countries;
#You will now explore the relationship between the size of a country in terms of surface area and in terms of population using grouping fields created with CASE.

#Instruction 1-Using the populations table focused only for the year 2015, create a new field AS popsize_group to organize population size into
#'large' (> 50 million),
#'medium' (> 1 million), and
#'small' groups. Select only the country code, population size, and this new popsize_group as fields.

SELECT p.country_code, p.size,
  -- start CASE here with WHEN and THEN
    CASE WHEN size > 50000000
        THEN 'large'
  -- layout other CASE conditions here
    WHEN size > 1000000
        THEN 'medium'
  -- end CASE here with ELSE & END
    ELSE 'small' END
  -- provide the alias of popsize_group to SELECT the new field
    AS popsize_group
-- which table?
FROM populations AS p
-- any conditions to check?
WHERE year = 2015;

#Instruction 2-Use INTO to save the result of the previous query as pop_plus. You can see an example of this in the countries_plus code in the assignment text. Make sure to include a ; at the end of your WHERE clause!
#Then, include another query below your first query to display all the records in pop_plus using SELECT * FROM pop_plus; so that you generate results and this will display pop_plus in

SELECT p.country_code, p.size,
  -- start CASE here with WHEN and THEN
    CASE WHEN size > 50000000
        THEN 'large'
  -- layout other CASE conditions here
    WHEN size > 1000000
        THEN 'medium'
  -- end CASE here with ELSE & END
    ELSE 'small' END
  -- provide the alias of popsize_group to SELECT the new field
    AS popsize_group
-- which table?
INTO pop_plus
FROM populations AS p
-- any conditions to check?
WHERE p.year = 2015;

SELECT *
FROM pop_plus;


#Instruction 3- Keep the first query intact that creates pop_plus using INTO.
Write a query to join countries_plus AS c on the left with pop_plus AS p on the right matching on the country code fields.
Sort the data based on geosize_group, in ascending order so that large appears on top.
Select the name, continent, geosize_group, and popsize_group fields.

SELECT p.country_code, p.size,
  -- start CASE here with WHEN and THEN
    CASE WHEN size > 50000000
        THEN 'large'
  -- layout other CASE conditions here
    WHEN size > 1000000
        THEN 'medium'
  -- end CASE here with ELSE & END
    ELSE 'small' END
  -- provide the alias of popsize_group to SELECT the new field
    AS popsize_group
-- which table?
INTO pop_plus
FROM populations AS p
-- any conditions to check?
WHERE p.year = 2015;

SELECT c.name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus AS p
ON c.code = p.country_code
ORDER BY geosize_group;
 
# LEFT JOIN
#Now you'll explore the differences between performing an inner join and a left join using the cities and countries tables.
#You'll begin by performing an inner join with the cities table on the left and the countries table on the right. Remember to alias the name of the city field as city and the name of the country field as country.
#You will then change the query to a left join. Take note of how many records are in each query here!

#Instruction 1-Fill in the code based on the instructions in the code comments to complete the inner join. Note how many records are in the result of the join in the query result tab.
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
INNER JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;

#Instruction 2-Change the code to perform a LEFT JOIN instead of an INNER JOIN. After executing this query, note how many records the query result contains.
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
LEFT JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;

#LEFT JOIN (2)

#Next, you'll try out another example comparing an inner join to its corresponding left join. Before you begin though, take note of how many records are in both the countries and languages tables below.
#You will begin with an inner join on the countries table on the left with the languages table on the right. Then you'll change the code to a left join in the next bullet.
#Note the use of multi-line comments here using /* and */.

#Instruction 1-Perform an inner join. Alias the name of the country field as country and the name of the language field as language.
#Sort based on descending country name.

/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- inner join with languages (as l) on the right
INNER JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;

#Instruction 2-Perform a left join instead of an inner join. Observe the result, and also note the change in the number of records in the result.
#Carefully review which records appear in the left join result, but not in the inner join result.

SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- inner join with languages (as l) on the right
LEFT JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;

#LEFT JOIN (3)

#Instruction 1-Begin with a left join with the countries table on the left and the economies table on the right.
#Focus only on records with 2010 as the year.

-- 5. Select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- countries (alias c) on the left
FROM countries AS c
-- join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE e.year = 2010;

#Instruction 2-Modify your code to calculate the average GDP per capita AS avg_gdp for each region in 2010.
#Select the region and avg_gdp fields.

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- countries (alias c) on the left
FROM countries AS c
-- join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE e.year = 2010
GROUP BY region;

#Instruction 3- Arrange this data on average GDP per capita for each region in 2010 from highest to lowest average GDP per capita.

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- countries (alias c) on the left
FROM countries AS c
-- join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE e.year = 2010
GROUP BY region
ORDER BY avg_gdp DESC;

#FULL JOIN
#In this exercise, you'll examine how your results differ when using a full join versus using a left join versus using an inner join with the countries and currencies tables.
#You will focus on the North American region and also where the name of the country is missing. Dig in to see what we mean!
#Begin with a full join with countries on the left and currencies on the right. The fields of interest have been SELECTed for you throughout this exercise.
#Then complete a similar left join and conclude with an inner join.

#Instruction 1-Choose records in which region corresponds to North America or is NULL.

SELECT name AS country, code, region, basic_unit
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

#Instruction 2-Repeat the same query as above but use a LEFT JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN result!
SELECT name AS country, code, region, basic_unit
FROM countries
LEFT JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

#Instruction 3-Repeat the same query as above but use an INNER JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN and LEFT JOIN results!

SELECT name AS country, code, region, basic_unit
FROM countries
INNER JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

# FULL JOIN (2)

#Instruction 1- Choose records in which countries.name starts with the capital letter 'V' or is NULL.
#Arrange by countries.name in ascending order to more clearly see the results.

SELECT countries.name, code, languages.name AS language
FROM languages
FULL JOIN countries
USING (CODE)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

#Instruction 2-Repeat the same query as above but use a left join instead of a full join. Note what has changed compared to the full join result!
SELECT countries.name, code, languages.name AS language
FROM languages
LEFT JOIN countries
USING (CODE)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

#Instruction 3- Repeat once more, but use an inner join instead of a left join. Note what has changed compared to the full join and left join results.
SELECT countries.name, code, languages.name AS language
FROM languages
INNER JOIN countries
USING (CODE)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

#FULL JOIN(3)
#Complete a full join with countries on the left and languages on the right.
#Next, full join this result with currencies on the right.
#Use LIKE to choose the Melanesia and Micronesia regions (Hint: 'M%esia').
#Select the fields corresponding to the country name AS country, region, language name AS language, and basic and fractional units of currency.

SELECT country.name AS country, region, language.name AS language,
       cur.basic_unit, cur.frac_unit
FROM countries AS country
FULL JOIN languages AS language
USING (code)
FULL JOIN currencies AS cur
USING (code)
WHERE region LIKE 'M%esia';

#CROSS JOIN- A table of two cities
#Create the cross join as described above. (Recall that cross joins do not use ON or USING.)
#Make use of LIKE and Hyder% to choose Hyderabad in both countries.
#Select only the city name AS city and language name AS language.

#Instruction 1-Create the cross join as described above. (Recall that cross joins do not use ON or USING.)
#Make use of LIKE and Hyder% to choose Hyderabad in both countries.
#Select only the city name AS city and language name AS language.

-- 4. Select fields
SELECT c.name AS city, l.name AS language
FROM cities AS c
CROSS JOIN languages AS l
WHERE c.name LIKE 'Hyder%';

#Instruction 2-Use an inner join instead of a cross join. Think about what the difference will be in the results for this inner join result and the one for the cross join.
SELECT c.name AS city, l.name AS language
FROM cities AS c
INNER JOIN languages AS l
ON c.country_code = l.code
WHERE c.name LIKE 'Hyder%';

#OUTER CHALLENGE

#Instruction 1-Select country name AS country, region, and life expectancy AS life_exp.
#Make sure to use LEFT JOIN, WHERE, ORDER BY, and LIMIT.

SELECT co.name AS country, region, p.life_expectancy AS life_exp
FROM countries AS co
LEFT JOIN populations AS p
ON co.code=p.country_code
WHERE p.year = 2010
ORDER BY life_exp
LIMIT 5;

##2.3-Set theory clauses

#UNION
#Near query result to the right, you will see two new tables with names economies2010 and economies2015.

#Instruction 1- Combine these two tables into one table containing all of the fields in economies2010. The economies table is also included for reference.
#Sort this resulting single table by country code and then by year, both in ascending order.

SELECT *
-- 2010 table will be on top
FROM economies2010
-- which set theory clause?
UNION
-- pick specified columns from 2015 table
SELECT *
-- 2015 table on the bottom
FROM economies2015
-- order accordingly
ORDER BY code, year;

#UNION (2)

#Determine all (non-duplicated) country codes in either the cities or the currencies table. The result should be a table with only one field called country_code.
#Sort by country_code in alphabetical order.


SELECT country_code
FROM cities
UNION
SELECT code
FROM currencies
ORDER BY country_code;

#UNION ALL
#As you saw, duplicates were removed from the previous two exercises by using UNION.To include duplicates, you can use UNION ALL.

#Instruction- Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables. Order by code then year.
#The result of the query should only have two columns/fields. Think about how many records this query should result in.
#You'll use code very similar to this in your next exercise after the video. Make note of this code after completing it.

SELECT code, year
FROM economies
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;

#INTERSECT

#Repeat the previous UNION ALL exercise, this time looking at the records in common for country code and year for the economies and populations tables.

#Instruction- Again, order by code and then by year, both in ascending order.
#Note the number of records here (given at the bottom of query result) compared to the similar UNION ALL query result (814 records).

SELECT code, year
FROM economies
INTERSECT
SELECT country_code, year
FROM populations
ORDER BY code, year;

#EXCEPT
#Get the names of cities in cities which are not noted as capital cities in countries as a single field result.
#Note that there are some countries in the world that are not included in the countries table, which will result in some cities not being labeled as capital cities when in fact they are.

#Instruction-Order the resulting field in ascending order. Can you spot the city/cities that are actually capital cities which this query misses?
SELECT city.name
FROM cities AS city
EXCEPT
SELECT country.capital
FROM countries AS country
ORDER BY name;

#EXCEPT (2)
#Order by capital in ascending order.
#The cities table contains information about 236 of the world's most populous cities. The result of your query may surprise you in terms of the number of capital cities that DO NOT appear in this list!

SELECT country.capital
FROM countries AS country
EXCEPT
SELECT city.name
FROM cities AS city
ORDER BY capital;

# SEMI-JOIN

#Instruction 1-Flash back to our Intro to SQL for Data Science course and begin by selecting all country codes in the Middle East as a single field result using SELECT, FROM, and WHERE.

SELECT country.code
FROM countries AS country
WHERE country.region = 'Middle East';

#Instruction 2- Comment out the answer to the previous tab by surrounding it in /* and */. You'll come back to it!
#Below the commented code, select only unique languages by name appearing in the languages table.
#Order the resulting single field table by name in ascending order.

SELECT code
  FROM countries
WHERE region = 'Middle East';

SELECT DISTINCT lang.name
FROM languages AS lang
ORDER BY lang.name;

#Instruction 3-Now combine the previous two queries into one query:
#Add a WHERE IN statement to the SELECT DISTINCT query, and use the commented out query from the first instruction in there. That way, you can determine the unique languages spoken in the Middle East.
#Carefully review this result and its code after completing it. It serves as a great example of subqueries, which are the focus of Chapter 4.
SELECT DISTINCT name
FROM languages
WHERE code IN
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
ORDER BY name;

#Instruction 1
#Instruction 2
#Instruction 3
