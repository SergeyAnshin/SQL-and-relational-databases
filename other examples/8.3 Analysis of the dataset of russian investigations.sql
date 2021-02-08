/* 1 - количество проведенных расследований */

select count(distinct investigation) 
from russia_investigation_draft;                                                 



/* 2 - средняя длительность расследований */ 

select avg(list_of_dur) 
from (select DATEDIFF(investigation_end, investigation_start) as list_of_dur
from russia_investigation_draft group by investigation) as avd_dur;               



/* 3 - количество подозреваемых */
 
select count(distinct name_person) from russia_investigation_draft;                   



/* 4 - количество осужденных */

select count(distinct name_person, overturned, pardoned) as numbr_of_convicted
from russia_investigation_draft
where name_person <> '' and overturned = 'FALSE' and pardoned = 'FALSE';          



/* 5 - количество иностранных участников */

select count(distinct name_person, american) as numbr_of_not_resident
from russia_investigation_draft
where american = 'FALSE';                                                         



/* 6 - среднее время с начала расследования до момента признания вины или осуждения */ 

select avg(cp_days)
from  russia_investigation_draft;                                                 



/* 7 - максимальная длительность расследования */

select max(list_of_dur) 
from (select DATEDIFF(investigation_end, investigation_start) as list_of_dur
from russia_investigation_draft group by investigation) as max_dur;               

