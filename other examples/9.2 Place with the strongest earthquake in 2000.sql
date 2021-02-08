select place
from earthquake
where occurred_on > '2000-01-01' and occurred_on < '2000-03-31'
order by magnitude desc
limit 1;