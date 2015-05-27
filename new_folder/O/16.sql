#16. Найти рассы, которым соответствуют все профессии.
#Вывод: Название рассы, Название фракции

#make it look nice
select t2.race, races.faction
from
(
	#number of learnt uniq proffs
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
) as t2
inner join races
	on races.race = t2.race
;