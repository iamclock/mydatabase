#18.Найти все пары игроков, у которых средний уровень по профессиям совпадает с точностью до 0.5%.
#Причём если пара (i, j) выведена, то пару (j, i) выводить не нужно.

select distinct concat(
		'(',
		least(avg_skills1.pid,avg_skills2.pid),
        ', ',
        greatest(avg_skills1.pid,avg_skills2.pid),
        ')'
) as res
from 
(# average player skills
	select player_id as pid, avg(skill) as skill
	from player_proffs
	group by player_id
) as avg_skills1
inner join 
(# average player skills
	select player_id as pid, avg(skill) as skill
	from player_proffs
	group by player_id
) as avg_skills2
on avg_skills1.pid != avg_skills2.pid
where 
	100*least(avg_skills1.skill,avg_skills2.skill)/greatest(avg_skills1.skill,avg_skills2.skill) > 99.5
;
