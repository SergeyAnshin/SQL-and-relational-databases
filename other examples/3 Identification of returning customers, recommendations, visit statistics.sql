create database task_class;
use task_class;



/* 1 - Identification of returning customers*/

create table users
(user_id smallint unsigned,
product_id smallint unsigned,
transaction_date date);

insert into users values
('1','101','20-2-12'),
('2','105','20-2-13'),
('1','111','20-2-14'),
('3','121','20-2-15'),
('1','101','20-2-16'),
('2','105','20-2-17'),
('4','101','20-2-16'),
('3','105','20-2-15');

select user_id, transaction_date
from (
		select user_id, transaction_date, row_number() over (partition BY user_id order by transaction_date) as n
		from users
		) as tbl_1
where n = 2;




/* 2 - Recommendations for persons */

create table friends 
(user_id smallint unsigned,
friend smallint unsigned);

create table likes 
(user_id smallint unsigned,
page_likes varchar(2));

insert into friends values
('1','2'),
('1','3'),
('1','4'),
('2','1'),
('3','1'),
('3','4'),
('4','1'),
('4','3');

insert into likes values
('1','A'),
('1','B'),
('1','C'),
('2','A'),
('3','B'),
('3','C'),
('4','B');

/* 2.1 - first option */

select user_id, friend, recommended_pages
from friends
inner join (
			select user_id as u_id, GROUP_CONCAT(page_likes) as recommended_pages
			from likes 
			group by user_id
			) as tbl_1
on user_id = u_id;

/* 2.2 - second option */

select user_id, friends, REPLACE(recommended_pages, ',', '') as recommended_pages
from
   (select user_id, f.friend as friends, user_likes, replace(user_likes, list_likes, '') as recommended_pages
   from
      (select user_id, friend, user_likes
      from friends
      inner join 
         (select user_id as u_id, GROUP_CONCAT(page_likes) as user_likes
         from likes 
         group by user_id) as tbl_1
      on user_id = u_id) f
   inner join 
      (select friend, GROUP_CONCAT(page_likes) as list_likes
      from
         (select distinct friend, page_likes
         from friends 
         left join likes l
         on friend = l.user_id) as t1
      group by friend) l
   on f.friend = l.friend) as t3
where recommended_pages != user_likes;



/* 3 - Visit statistics */

create table mobile
(user_id smallint unsigned,
page_url varchar(2));

create table web
(user_id smallint unsigned,
page_url varchar(2));

insert into mobile values
('1','A'),
('2','B'),
('3','C'),
('4','A'),
('9','B'),
('2','C'),
('10','B');

insert into web values
('6','A'),
('2','B'),
('3','C'),
('7','A'),
('4','B'),
('8','C'),
('5','B');

select type, cnt/(
					select count(user_id) as total_num
					from (select user_id from mobile union select user_id from web) 
					as t2) * 100 as percent 
from (
		(select count(user_id) as cnt, 'visit only mobile' as 'type' from web where user_id not in (select user_id from mobile))
		union all
		(select count(user_id) as cnt, 'visit only web' as 'type' from mobile where user_id not in (select user_id from web))
		union all
		(select count(distinct w.user_id) as cnt, 'visit both' as 'type' from web w join mobile m on w.user_id = m.user_id)
		) as t1;
 
