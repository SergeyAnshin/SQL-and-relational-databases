create database task_class;
use task_class;



/* 1 - Determine the percentage of students who were born in April and came to class on their birthday */

create table students
(student_id int,
school_id int,
grade_level int,
date_of_birth date);

create table attendance
(student_id int,
school_date date,
attendance enum('0','1'));

insert into attendance values
('1','2020-04-03','0'),
('2','2020-04-03','1'),
('3','2020-04-03','1'),
('1','2020-04-04','1'),
('2','2020-04-04','1'),
('3','2020-04-04','1'),
('1','2020-04-05','0'),
('2','2020-04-05','1'),
('3','2020-04-05','1'),
('4','2020-04-05','1');

insert into students values
('1','2','5','2012-04-03'),
('2','1','4','2013-04-04'),
('3','1','3','2014-04-05'),
('4','2','4','2013-04-03');

select count(*)/(
					select count(*) 
					from students 
					where date_format(date_of_birth,'%m') = 04
					)*100 as percent
from attendance
where (student_id, date_format(school_date,'%d.%m')) in (select student_id, date_format(date_of_birth,'%d.%m') from students)
and attendance = '1';



/* 2 - Determine which tasks belong to projects, count the number of tasks in each project
	   define the beginning and end of the project, determine the duration of the project */

create table projects 
(task_id int,
start_date date,
end_date date);

insert into projects values
('1','2020-10-01','2020-10-02'),
('2','2020-10-02','2020-10-03'),
('3','2020-10-03','2020-10-04'),
('4','2020-10-13','2020-10-14'),
('5','2020-10-14','2020-10-15'),
('6','2020-10-28','2020-10-29'),
('7','2020-10-30','2020-10-31');


select project_id, count(*) as number_of_task, start_date, max(end_date) as stop_date, 
	   datediff(max(end_date),start_date) as project_duration
from (select task_id, start_date, end_date, 
	         @prev_value := if(@prev_value is null, '0000-00-00',(select end_date from projects where task_id = p.task_id - 1)), 
             case
	            when @prev_value = start_date then @rank_count 
	            when start_date != @prev_value then @rank_count := @rank_count + 1
             end as project_id
      from projects p, (select @prev_value := null) a, (select @rank_count := 0) b) as tbl1
group by project_id;