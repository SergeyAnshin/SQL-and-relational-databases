select place, occurred_on, magnitude 
from earthquake
where occurred_on > '1993-01-01' and occurred_on < '1993-12-31'
order by magnitude desc
limit 1;