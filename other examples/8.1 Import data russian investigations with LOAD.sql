create database russia_investigation_db;                                                  /* 1 шаг - создание базы данных   */ 
use russia_investigation_db;

create table russia_investigation_draft                                                   /* 2 шаг - создание таблицы   */
(row_russia_investigation_id smallint unsigned,
investigation varchar(255),
investigation_start date,
investigation_end varchar(255),
investigation_days varchar(255),
name_person varchar(255),
indictment_days varchar(255),
result_of_charge varchar(255),
cp_date varchar(255),
cp_days varchar(255),
overturned varchar(255),
pardoned varchar(255),
american varchar(255),
president varchar(255),
constraint pk_row_russia_investigation_id primary key (row_russia_investigation_id));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/russian_inv.txt'          /* 3 шаг - загрузка данных   */      
into table russia_investigation_draft
fields terminated by ','
enclosed by '"'                                                                           /* решение проблемы с распознованием столбцов   */
lines terminated by '\n'
ignore 1 lines;