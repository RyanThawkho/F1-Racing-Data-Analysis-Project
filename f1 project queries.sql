--i want to explore why the best are the best in formula 1 racing!

--top 10 drivers of all time with the most points(ok)
select top 10 d.first_name +' '+ d.last_name as driver, SUM(re.points) points from drivers d join results re on
re.driverId = d.driverId join races r on
r.raceId = re.raceId
group by d.first_name, d.last_name
order by points desc

--how many point did the best driver score each season(ok)
with top_drivers as (
select top 10 d.first_name +' '+ d.last_name as driver, SUM(re.points) points from drivers d join results re on
re.driverId = d.driverId join races r on
r.raceId = re.raceId
group by d.first_name, d.last_name
order by points desc
)
select d.first_name+' '+d.last_name driver, r.year, SUM(re.points) total_points from drivers d join results re on
re.driverId = d.driverId join races r on
r.raceId = re.raceId join top_drivers td on
td.driver = d.first_name+' '+d.last_name
where td.driver in (select driver from top_drivers
					where driver = 'Michael Schumacher')
group by d.first_name, d.last_name, r.year


--top 10 drivers of all time with the most race wins(ok)
select top 10 d.first_name, COUNT(*) wins from results re join races r on
r.raceId = re.raceId join drivers d on
d.driverId = re.driverId
group by d.first_name, re.final_position
having re.final_position = 1
order by wins desc


--how many races did the best driver win each season(ok)
with top_drivers as (
select top 10 d.first_name +' '+ d.last_name as driver, SUM(re.points) points from drivers d join results re on
re.driverId = d.driverId join races r on
r.raceId = re.raceId
group by d.first_name, d.last_name
order by points desc
)
select d.first_name+' '+d.last_name, r.year, COUNT(*) wins from races r join results re on
r.raceId = re.raceId join drivers d on
d.driverId = re.driverId join top_drivers td on
td.driver = d.first_name+' '+d.last_name
where td.driver in (select driver from top_drivers
					where re.final_position = 1 and driver = 'lewis hamilton')
group by d.first_name, d.last_name, r.year



--top 10 constructors of all time with the most point(ok)
select top 10 c.name, sum(cr.points) total_points from constructors c join constructor_results cr on
c.constructorId = cr.constructorId
group by c.name
order by total_points desc


--top 10 constructors of all time with the most wins(ok)
select c.name, COUNT(*) total_wins from constructors c join constructor_results cr on
c.constructorId = cr.constructorId join races r on
r.raceId = cr.raceId
group by c.name
order by total_wins desc

alter table pit_stops 
alter column duration int

--top 10 most efficient teams with pit stops, what is the average duration of its pit stops
select top 10 c.name, AVG(p.milliseconds) avg_pit from races r join pit_stops p on
p.raceId = r.raceId join results re on
re.raceId = r.raceId join constructors c on
c.constructorId = re.constructorId 
group by c.name
order by avg_pit


select p.milliseconds from pit_stops p join races r on
r.raceId = p.raceId join constructor_results cr on
cr.raceId = r.raceId join constructors c on
c.constructorId = cr.constructorId 
where c.name = 'ferrari'


select * from drivers
select * from circuits
select * from races
select * from results
select * from constructor_results
select * from constructors
select * from pit_stops