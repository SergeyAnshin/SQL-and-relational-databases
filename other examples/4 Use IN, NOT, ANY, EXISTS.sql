/* use IN */

select actors_id, first_name
from actors
where actors_id in (
						select actors_id_in_r 
						from roles 
						where role_name = 'Street Kid'
						);
                    
                    
                    
/* use NOT IN */

select movies_id, name
from movies
where movies_id not in (
							select movie_id_in_mg 
							from movies_genres 
							where genre = 'Comedy'
							);
													
                        
                        
/* use EXISTS */

select name 
from movies 
where exists (
					select * 
					from movies_genres 
					where genre = 'comedy'
					);



/* use ANY */

select movies_id_in_r 
from roles 
where actors_id_in_r = any(
								select actors_id 
								from actors 
								where gender <> 'M'
								);