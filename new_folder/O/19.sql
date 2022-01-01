#19. Для класса можно найти суммарное значение средних показателей скилов игроков. 
#	 Требуется найти классы у которых это значение минимально. 
#	 При этом эти классы должны содержать хотя бы 5 игроков.
#Вывод: Имена найденных классов

# Table should contain summ of average skills for all classes
# 	that was chosen by more than 5 players
create table if not exists avg_skills 
	select class_users.class, sum(av) as summary_skill
	from 
    # class_id with average skills
    (
		select class_id, av
		from (
		(# average player skills as t
			select player_id, avg(skill) as av
			from player_proffs
			group by player_id
		) as t 
		# joined w/ players to get race_id
		inner join players 
			on t.player_id = players.id
		)
	) as class_skills
    inner join
    # joined w/ classes that have at least 5 players
	(
		# number of players w/ such class
		select clases.id, clases.class, count(players.id) as num
		from clases
		inner join players
			on players.class_id = clases.id
		group by clases.id
		having num >= 5
    ) as class_users
	on class_skills.class_id = class_users.id
	group by class
;

select class
from avg_skills
where summary_skill = (select min(summary_skill) from avg_skills);

drop table avg_skills;