/* 1 - Number of cycle-sharing stations in rectangle*/

select                                                                         
case 
   when latitude between 47.594830 and 47.638502 then 'vertical rectangle'
   when latitude between 47.638502 and 47.669702 then 'horizontal rectangle'
   else 'anomaly'
end as rectangle_type,  
count(*) as number_of_station 
from station 
group by rectangle_type;



/* 2 - The most popular routes */

select * , (number_of_trip + number_of_trip1) as total 
from (
		select *
		from (
				select count(*) as number_of_trip, CONCAT_WS(',',from_station_id, to_station_id) as destination
				from trip
				group by destination
			    ) as a
	left join (
				select count(*) as number_of_trip1, CONCAT_WS(',',to_station_id,from_station_id) as destination1 
				from trip
				group by destination1
			    ) as b
	on a.destination = b.destination1
    ) as c
order by total desc
limit 10;


/* 3 - Change in the number of stations */

select install_date, count(*) 
from station
group by year(install_date)
order by install_date desc;



/* 4 - Change in the number of bikes */

select count(distinct bike_id) as unik_bike, year(date_start_trip) as year_res
from trip
group by year_res;



/* 5 - Change in the number of trips */

select count(*), year(date_start_trip) as year_trip
from trip
group by year_trip;



/* 6 - Maximum trip duration, average trip duration, minimum trip duration */

select max(trip_duration) as max_dur
from trip;

select start_time, stop_time
from trip 
where trip_duration = (select max(trip_duration) as max_dur
from trip);

select avg(trip_duration) as avg_dur
from trip;

select min(trip_duration) as min_dur
from trip;


/* 7 - Information about members,short-term pass holder */

select usertype, cnt_cl, cnt_cl/(select sum(count_cl) as sum_cl 
								 from (
										 select usertype, count(*) as count_cl
										 from trip
										 group by usertype
										 ) as cl_tb2)*100 as percent
from (
		select usertype, count(*) as cnt_cl 
		from trip
		group by usertype
		) as tbl1;
      
      
      
/* 8 - Information related to human gender */

select gender, numbr_of_per, numbr_of_per/(select sum(numbr_of_per)
									      from (
												  select gender, count(*) as numbr_of_per
												  from trip 
												  group by gender
                                                  ) as tbl_2) as percent
from (
		select gender, count(*) as numbr_of_per
		from trip 
		group by gender
		) as tbl_1;



/* 9 - Year of birth of the youngest client  */

select max(birthyear)
from trip;



/* 10 - Year of birth of the oldest client  */

select birthyear, count(*) as number_of_pers
from trip
group by birthyear
order by birthyear
limit 2;



/* 11 - Number of trips in different age groups */

select count(*) as number_of_person_in_group_age,
case 
   when age between 0 and 15 then 'age from 0 to 15'
   when age between 15 and 25 then 'age from 15 to 25'
   when age between 25 and 35 then 'age from 25 to 35'
   when age between 15 and 25 then 'age from 35 to 45'
   when age between 45 and 200 then 'age from 45'
   else 'anomaly'
end as group_age
from (
		select birthyear, ('2016'- birthyear) as age
		from trip 
		where year(date_start_trip) = '2016'
        ) as tabl_1
group by group_age;



/* 12 - Number of trips depending on the time of day */

select time(start_time) as time_start1, count(*) as number_of_trip,
case
   when time(start_time) between '00:00:00' and '06:00:00' then 'good night'
   when time(start_time) between '06:00:00' and '12:00:00' then 'good morning'
   when time(start_time) between '12:00:00' and '18:00:00' then 'good afternoon'
   when time(start_time) between '18:00:00' and '24:00:00' then 'good evening'
   else 'anomaly'
end as times_of_day
from trip
group by times_of_day;



/* 12 - Number of trips depending on the seasons */

select count(*),
case
   when month(date_start_trip) between 1 and 2 then 'winter'
   when month(date_start_trip) between 3 and 5 then 'spring'
   when month(date_start_trip) between 6 and 8 then 'summer'
   when month(date_start_trip) between 9 and 11 then 'autumn'
   when month(date_start_trip) = 12 then 'winter'
   else 'anomaly'
end as seasons 
from trip
group by seasons;



/* 13 - Information related to load by stations */

select from_station_id, number_of_trip_1day * current_dockcount * 365 as max_year_load_plan, max_year_load_actual
from (
		select from_station_id, 24/(avg(trip_duration)/3600) as number_of_trip_1day
		from trip
		group by from_station_id
        ) as tbl_1
inner join station on from_station_id = station_id
inner join (
			select from_station_id as f_s_id, count(*) as max_year_load_actual
			from trip
			where year(date_start_trip) = '2016'
			group by from_station_id
            ) as tbl_2 on from_station_id = f_s_id
order by max_year_load_actual desc;



/* 14 - Information related to weather */

select events_description, year(date_id) as ddd, count(*)
from weather 
group by events_description, ddd;



/* 15 - Number of trips in certain weather */

select events_description, count(*) as numder_of_trip
from trip
inner join weather on date_start_trip = date_id
group by events_description;
