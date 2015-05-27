#12. Найти рассы, которым соответствуют все профессии и ни одной специальности.
#Вывод: Название расс

select t1.race
from
#races with maximum learnt proffs
(
	select t.race, count(proff_id) as n_proffs
	from
	(
		# uniq combinations of (race : learnt proffession)
		select distinct players.race, proff_id
		from player_proffs
		inner join players
		on players.id = player_proffs.player_id
	) as t
	group by t.race
	#get only ones that learn all proffs
	having n_proffs = (select count(*) from proffs)
 ) as t1
 inner join 
#races with no specs
 (   
	select distinct race
    from races
	left outer join 
    (    
		# get uniq races of only players w/ specs
		select distinct race as race_with_spec
		from players
		inner join player_specs
				on player_specs.player_id = players.id
	) as t
	on races.race = t.race_with_spec 
	where race_with_spec is null
) as t2
on t1.race = t2.race;
