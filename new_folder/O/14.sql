#14. Найти игроков, выбравших самые популярные профессии. 
#    Самые популярные профессии - это профессии, выбранные наибольшим количеством игроков.
#Вывод: Неповторяющиеся имена игроков.

select distinct players.name
from
# players w/ most popular proffs
(
	select player_id
	from (
		# profession : players learnt
		select proff_id, count(player_id) as proff_rating
		from player_proffs
		group by proff_id
		) as t
		# player : rating of learnt proffessions
		inner join player_proffs
		on t.proff_id = player_proffs.proff_id
	where t.proff_rating = (
		select max(rating)
		from (
			select count(player_id) as rating 
			from player_proffs
			group by proff_id
		) as p
	)
) as tmp
# joined with players to get names
inner join players
on tmp.player_id = players.id
;