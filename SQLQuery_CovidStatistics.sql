Select * from CovidDeaths order by 3,4

--Select * from CovidVaccinations order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1

-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
where location like 'Turkey'
order by 1,2

-- Shows what percentage of population got Covid
Select Location, date, total_cases, population, (total_deaths/population)*100 as PercentPopulationInfected
from CovidDeaths
where location like 'Turkey'
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
Select Location, population, max(total_cases) as HighestInfectionCount, max((total_deaths/population))*100 as PercentPopulationInfected
from CovidDeaths
--where location like 'Turkey'
group by location, population
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population
Select Location, max(total_deaths) as TotalDeathCount from CovidDeaths
--where location like 'Turkey'
group by location
order by TotalDeathCount desc

-- looking at Total Population vs Vaccinations

select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location)
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where vac.new_vaccinations is not null and dea.continent is not null
order by 2,3