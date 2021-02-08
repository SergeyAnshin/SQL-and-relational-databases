select 
case
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN 0 and 60 THEN 'latitude between -90 and -60, longitude between 0 and 60'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN 0 and 60 THEN 'latitude between -60 and -30, longitude between 0 and 60'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN 0 and 60 THEN 'latitude between -30 and 0, longitude between 0 and 60'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN 0 and 60 THEN 'latitude between 0 and 30, longitude between 0 and 60'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN 0 and 60 THEN 'latitude between 30 and 60, longitude between 0 and 60'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN 0 and 60 THEN 'latitude between 60 and 90, longitude between 0 and 60'
   
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN 60 and 120 THEN 'latitude between -90 and -60, longitude between 60 and 120'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN 60 and 120 THEN 'latitude between -60 and -30, longitude between 60 and 120'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN 60 and 120 THEN 'latitude between -30 and 0, longitude between 60 and 120'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN 60 and 120 THEN 'latitude between 0 and 30, longitude between 60 and 120'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN 60 and 120 THEN 'latitude between 30 and 60, longitude between 60 and 120'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN 60 and 120 THEN 'latitude between 60 and 90, longitude between 60 and 120'
   
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN 120 and 180 THEN 'latitude between -90 and -60, longitude between 120 and 180'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN 120 and 180 THEN 'latitude between -60 and -30, longitude between 120 and 180'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN 120 and 180 THEN 'latitude between -30 and 0, longitude between 120 and 180'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN 120 and 180 THEN 'latitude between 0 and 30, longitude between 120 and 180'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN 120 and 180 THEN 'latitude between 30 and 60, longitude between 120 and 180'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN 120 and 180 THEN 'latitude between 60 and 90, longitude between 120 and 180'
   
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN -180 and -120 THEN 'latitude between -90 and -60, longitude between -180 and -120'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN -180 and -120 THEN 'latitude between -60 and -30, longitude between -180 and -120'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN -180 and -120 THEN 'latitude between -30 and 0, longitude between -180 and -120'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN -180 and -120 THEN 'latitude between 0 and 30, longitude between -180 and -120'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN -180 and -120 THEN 'latitude between 30 and 60, longitude between -180 and -120'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN -180 and -120 THEN 'latitude between 60 and 90, longitude between -180 and -120'
   
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN -120 and -60 THEN 'latitude between -90 and -60, longitude between -120 and -60'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN -120 and -60 THEN 'latitude between -60 and -30, longitude between -120 and -60'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN -120 and -60 THEN 'latitude between -30 and 0, longitude between -120 and -60'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN -120 and -60 THEN 'latitude between 0 and 30, longitude between -120 and -60'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN -120 and -60 THEN 'latitude between 30 and 60, longitude between -120 and -60'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN -120 and -60 THEN 'latitude between 60 and 90, longitude between -120 and -60'
   
   WHEN latitude BETWEEN -90 and -60 and longitude BETWEEN -60 and 0 THEN 'latitude between -90 and -60, longitude between -60 and 0'
   WHEN latitude BETWEEN -60 and -30 and longitude BETWEEN -60 and 0 THEN 'latitude between -60 and -30, longitude between -60 and 0'
   WHEN latitude BETWEEN -30 and 0 and longitude BETWEEN -60 and 0 THEN 'latitude between -30 and 0, longitude between -60 and 0'
   WHEN latitude BETWEEN 0 and 30 and longitude BETWEEN -60 and 0 THEN 'latitude between 0 and 30, longitude between -60 and 0'
   WHEN latitude BETWEEN 30 and 60 and longitude BETWEEN -60 and 0 THEN 'latitude between 30 and 60, longitude between -60 and 0'
   WHEN latitude BETWEEN 60 and 90 and longitude BETWEEN -60 and 0 THEN 'latitude between 60 and 90, longitude between -60 and 0'
   
   ELSE 'anomaly'
end as ranges,
count(*) as count_clm
from earthquake
group by ranges
order by count_clm desc
limit 1;