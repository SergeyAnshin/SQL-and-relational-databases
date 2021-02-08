/* 1 - Average trip duration from a station with maximum load */

select avg(trip_duration)
from trip 
where from_station_id = (
						select from_station_id as f_s_id
						from trip
						where year(date_start_trip) = '2016'
						group by from_station_id
						order by count(*) desc
						limit 1
						);



/* 2 - Number of trips and temperature  */

select 
(select count(*) as number_of_trip_min_temp
from trip
where date_start_trip = (select date_id
						 from weather 
						 where avr_temperature_f = (select min(avr_temperature_f) 
													from weather))) as number_of_trip_min_temp, 
(select count(*) as number_of_trip_max_temp
from trip
where date_start_trip = (select date_id
						 from weather 
						 where avr_temperature_f = (select max(avr_temperature_f) 
													from weather))) as number_of_trip_max_temp



/* 3 - The weather during the longest nigth trip  */

select * 
from weather 
where date_id = (
					select date(start_time)
					from (
							select start_time, stop_time, trip_duration
							from trip 
							where time(start_time) between '00:00:00' and '06:00:00' and 
							time(stop_time) between '00:00:00' and '06:00:00'
							order by trip_duration desc
							limit 1
                            ) as tbl1);
                       
                       
                       
/* 4 - Influence of wind on the number of trips  */                 
      
select date_start_trip, number_of_trip, avr_wind_speed_mph
from (
		select date_start_trip, count(*) as number_of_trip
		from trip
		where date_start_trip in (select date_id from weather)
		group by date_start_trip
	    ) as tbl1
join weather 
on date_start_trip = date_id
order by date_start_trip;



/* 5 - Place with the highest probability to get a bike */

select station_id, latitude, longitude, current_dockcount, number_of_trips
from station 
join (
		select from_station_id, count(*) as number_of_trips
		from trip 
		group by from_station_id
		) as tbl1
on station_id = from_station_id
where current_dockcount > (select avg(current_dockcount) from station)
order by number_of_trips
limit 5;



/* 6 - Rainy day with maximum trips */

select date_start_trip, count(*) as number_of_trips
from trip
where date_start_trip in (
							select date_id 
							from weather 
							where events_description like '%Rain%'
							)
group by date_start_trip
order by number_of_trips desc
limit 1;



/* 7 - Availability of bicycles at different times */
									    
/* 7.1 - First option */						    

select *
from (
		select year(date_start_trip) as date_trip, from_station_id, time(start_time) as time_trip, count(*) as number_of_trips
        from trip
        where time(start_time) between '12:00:00' and ':00:00'
        group by date_trip, from_station_id, time_trip
        order by from_station_id, number_of_trips
        ) as tbl1
group by from_station_id
order by from_station_id;

/* 7.2 - Second option */

select t3.station_id, t3.date_trip, t3.hour_trip, 
       s.install_dockcount - t3.number_trips_from_station as availability_of_bicycles_min,
       s.install_dockcount + t3.number_trips_to_station - t3.number_trips_from_station as availability_of_bicycles_max
from (
		select * 
		from (
				select from_station_id as station_id, date_start_trip as date_trip, 
				hour(start_time) as hour_trip, count(*) as number_trips_from_station
				from trip t
				group by from_station_id, date_trip, hour_trip
				order by from_station_id, date_trip, hour_trip
				) as t1
		inner join (
						select to_station_id as station_id, date(stop_time) as date_trip, 
						hour(stop_time) as hour_trip, count(*) as number_trips_to_station
						from trip
						group by to_station_id, date_trip, hour_trip
						order by to_station_id, date_trip,hour_trip
						) as t2
		using (station_id, date_trip, hour_trip)) as t3
left join 
station s
on t3.station_id = s.station_id;


	  
/* 8 - Station with the highest number of trips made by people 45+*/

select from_station_id, count(*) as cnt
from trip
where year(date_start_trip) - birthyear >= '45' and birthyear > 1900
group by from_station_id
order by cnt desc
limit 1;



/* 9 - All stations were modified? */

select
(
	select count(*)
	from station 
	where modification_date > 0
	) as number_mod_station,

(
	select count(station_id) 
	from station
	) as total_stations
