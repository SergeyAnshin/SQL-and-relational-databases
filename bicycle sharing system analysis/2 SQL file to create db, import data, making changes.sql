create database cycle_sharing_db;                      /* STAGE 1 - CREATING A DATABASE */
use cycle_sharing_db;
drop table trip;
drop database cycle_sharing_db;

create table station                                  
(station_id varchar(255),
station_name varchar(255),
latitude decimal(8,6),
longitude decimal(9,6),
install_date varchar(255),                             /* change data type to date */
install_dockcount tinyint(2) unsigned,
modification_date varchar(255),                        /* change data type to date */
current_dockcount tinyint(2) unsigned,
decommission_date varchar(255),                        /* change data type to на date */
constraint pk_station_id primary key (station_id));

create table trip 
(trip_id mediumint(6) unsigned,
start_time varchar(255),                               /* change data type to datetime */
stop_time varchar(255),                                /* change data type to datetime */
bike_id varchar(255),
trip_duration decimal(8,3),
from_station_name varchar(255),
to_station_name varchar(255),
from_station_id varchar(255), 
to_station_id varchar(255),
usertype varchar(255),
gender varchar(255),
birthyear varchar(255),                                /* change data type to year */
constraint pk_trip_id primary key (trip_id));

create table weather
(date_id varchar(10),                                  /* change data type to date */
max_temperature_f tinyint(3) unsigned,
avr_temperature_f tinyint(3) unsigned,                       
min_temperature_f tinyint(3) unsigned,        
max_dew_point_f tinyint(3) unsigned, 
avr_dew_point_f tinyint(3) unsigned,
min_dew_point_f tinyint(3) unsigned,
max_humidity tinyint(3) unsigned,
avr_humidity tinyint(3) unsigned,
min_humidity tinyint(3) unsigned,
max_sea_level_pressure_in decimal(4,2),
avr_sea_level_pressure_in decimal(4,2),
min_sea_level_pressure_in decimal(4,2),
max_visibility_miles tinyint(3) unsigned,
avr_visibility_miles tinyint(3) unsigned,
mix_visibility_miles tinyint(3) unsigned,
max_wind_speed_mph tinyint(3) unsigned,
avr_wind_speed_mph tinyint(3) unsigned,
max_gust_speed_mph varchar(10),                        
precipitation_in decimal(4,2),
events_description varchar(100),
constraint pk_date_id primary key (date_id));



load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/station.txt'         /* STAGE 2 - DATA IMPORT */      
into table station
fields terminated by ','
enclosed by '"'                                                                           
lines terminated by '\r\n'
ignore 1 lines;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/trip.txt' ignore     /* ignore, use to remove duplicates */       
into table trip
fields terminated by ','
enclosed by '"'                                                                             
lines terminated by '\r\n'
ignore 1 lines;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather.txt'        
into table weather
fields terminated by ','
enclosed by '"'                                                                             
lines terminated by '\r\n'
ignore 1 lines;



set SQL_SAFE_UPDATES = 0;                                                       /* disable safe_update_mode to making changes */

alter table station add (install_date_new date);                                /* STAGE 3 - CHANGE DATA TYPE FOR COLUMES */
update station set install_date_new = STR_TO_DATE(install_date, '%c/%e/%Y');
alter table station drop install_date;
alter table station change column install_date_new install_date date;

alter table station add (modification_date_new date);
update station set modification_date_new = STR_TO_DATE(modification_date, '%c/%e/%Y');
alter table station drop modification_date;
alter table station change column modification_date_new modification_date date;

alter table station add (decommission_date_new date);
update station set decommission_date_new = STR_TO_DATE(decommission_date, '%c/%e/%Y');
alter table station drop decommission_date;
alter table station change column decommission_date_new decommission_date date;



alter table trip add (start_time_new datetime);
update trip set start_time_new = STR_TO_DATE(start_time, '%c/%e/%Y %k:%i');
alter table trip drop start_time;
alter table trip change column start_time_new start_time datetime;

alter table trip add (stop_time_new datetime);
update trip set stop_time_new = STR_TO_DATE(stop_time, '%c/%e/%Y %k:%i');
alter table trip drop stop_time;
alter table trip change column stop_time_new stop_time datetime;

alter table trip add (birthyear_new year);
update trip set birthyear_new = STR_TO_DATE(birthyear, '%Y');
alter table trip drop birthyear;
alter table trip change column birthyear_new birthyear year;



alter table weather add (date_id_new date);
update weather set date_id_new = STR_TO_DATE(date_id, '%c/%e/%Y');
alter table weather drop date_id;
alter table weather change column date_id_new date_id date;



alter table trip add (date_start_trip date);                             /* STAGE 4 - ADD COLUMN TO CREATE FOREIGN KEY TO THE WEATHER TABLE */
update trip set date_start_trip = date(start_time);

set SQL_SAFE_UPDATES = 1;                                                /* enable safe_update_mode */



alter table trip                                                         /* STAGE 5 - CREATING RELATIONSHIPS BETWEEN TABLES */
add constraint fk_trip_station_id
foreign key (from_station_id) references station (station_id);

alter table trip 
add constraint fk_trip_station_id_2
foreign key (to_station_id) references station (station_id);



alter table weather  
add constraint pk_date_id
primary key (date_id);

alter table trip 
add constraint fk_trip_date_id
foreign key (date_start_trip) references weather (date_id);



alter table trip drop column from_station_name,                         /* STAGE 6 - REMOVING UNNECESSARY DATA */
                 drop column to_station_name;
