--Global Statistics
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
	SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL
	AND new_cases != 0
ORDER BY 1,2

--Total Infected Cases (by Continent)
SELECT location, SUM(new_cases) AS total_cases 
FROM deaths
WHERE continent IS NULL
	AND location NOT IN ('World', 'European Union', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY total_cases DESC

--Total Infected Cases (by Countries)
SELECT location, SUM(new_cases) AS total_infected_cases 
FROM deaths
WHERE continent IS NOT NULL
	AND new_cases IS NOT NULL
GROUP BY location
ORDER BY total_infected_cases DESC

--Total Deaths (by Continent)
SELECT location, SUM(new_deaths) AS total_death_count 
FROM deaths
WHERE continent IS NULL
	AND location NOT IN ('World', 'European Union', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY total_death_count DESC

--Total Deaths (by Countries)
SELECT location, SUM(new_deaths) AS total_death_count 
FROM deaths
WHERE total_deaths IS NOT NULL
	AND continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC

--Percentage of Infected Population (2020)
SELECT location, population, MAX(total_cases) AS highest_infection_count,
	MAX(total_cases/population)*100 AS percent_population_infected
FROM deaths
WHERE total_cases IS NOT NULL
	AND continent IS NOT NULL
	AND date BETWEEN '2020-01-01' AND '2020-12-31'
	--AND location IN ('China', 'Indonesia', 'India', 'Mexico', 'South Africa')
GROUP BY location, population
ORDER BY percent_population_infected DESC

--Most used vaccine types
SELECT vaccine_name, COUNT(vaccine_name) AS number_of_user_countries 
FROM vac_producer
GROUP BY vaccine_name
ORDER BY number_of_user_countries DESC

--Availability of Handwashing Facilities GDP per capita chart analyzed using excel spreadsheet