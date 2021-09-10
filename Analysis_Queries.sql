SELECT *
	FROM public."Receipes";

--Update flavor_profile from '-1' to 'NOT AVAILABLE'
Update public."Receipes" SET flavor_profile = 'NOT AVAILABLE' 
where flavor_profile='-1';

--Calculate total meal types by state.
SELECT state, COUNT(Distinct course) AS "Total Number of MealTypes"
FROM public."Receipes"
GROUP BY state;

--Select Distinct(course) from public."Receipes" where state='Maharashtra'
SELECT Distinct course FROM public."Receipes" where state='MAHARASHTRA';
--We will provide how many recipes have used certain ingredients like Rice, sugar and milk.
Select * from public."Receipes" 
where ingredients Ilike '%Rice%';

Select * from public."Receipes" 
where ingredients Ilike '%sugar%'
and ingredients Ilike '%milk%';

--How many diet types per state
SELECT state, COUNT(Distinct diet) AS "Total Number of Diettypes"
FROM public."Receipes"
GROUP BY state;

--How many receipes are spicy by region
SELECT Region, COUNT(flavor_profile) AS "Total Number of Spicy receipes"
FROM public."Receipes"
where flavor_profile='spicy'
GROUP BY Region;

--Provide the top 5 states that have highest rainfall in 2015.
SELECT
   DISTINCT(state),
   "Annual_Rainfall_mm"
FROM
   public."Receipes"
where "Annual_Rainfall_mm" is NOT NULL
ORDER BY
      "Annual_Rainfall_mm" desc
	  FETCH first 5 rows only;
	
--What is the average number of spicy receipe orders where the rainfall is the highest.
SELECT Distinct(state), "Annual_Rainfall_mm", Round(AVG(orders_num),2)
FROM public."Receipes"
where flavor_profile='spicy' and "Annual_Rainfall_mm" in (SELECT DISTINCT("Annual_Rainfall_mm")
from public."Receipes"
where "Annual_Rainfall_mm" is NOT NULL
ORDER BY "Annual_Rainfall_mm" desc
FETCH first 5 rows only)
GROUP BY state,"Annual_Rainfall_mm"
	  
--Ingredients used mostly in areas where there is less Rainfall/Dry land.
SELECT "name", ingredients, state,region,
   "Annual_Rainfall_mm"
FROM
   public."Receipes"
where "Annual_Rainfall_mm" is NOT NULL
ORDER BY
      "Annual_Rainfall_mm" asc
	  FETCH first 5 rows only;