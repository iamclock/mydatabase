#17. Для кажого игрока вывести строку следующего вида. 
#	"Игрок ИМЯ_ИГРОКА выбрал рассу ИМЯ_РАССЫ фракции ИМЯ_ФРАКЦИИ.
#	 Класс игрока КЛАСС ИГРОКА, при этом игроком выбраны следующие подклассы СТРОКА ИМЁН_ПОДКЛАССОВ.
#	 Минимальный уровень специальности игрока равен МИНИМАЛЬНЫЙ_УРОВЕНЬ и это специальность ИМЯ_СПЕЦИАЛЬНОСТИ. 
#    Игроком выбрано КОЛИЧЕСТВО_ПРОФЕССИЙ профессий".

select concat(
	'Игрок ', gen.name,
    ' выбрал рассу ', gen.race,
    ' фракции ', gen.faction, '. ',
    'Класс игрока ', gen.class, ', ',
    ' при этом игроком выбраны следующие подклассы: ', subcls.str, '. ',
    'Минимальный уровень специальности игрока равен ', min_lvls.lvl,
    ' и это специальность ', min_lvls.name, '. ',
    'Игроком выбрано ', n_proffs.num, ' профессии.'
) as str
from 
	(
	# general player info
	select  players.id, players.name, players.race, players.faction, clases.class
	from players
	inner join clases 
		on players.class_id = clases.id
	) as gen
inner join
	(
	# players subclasses string
	select player_id as id, group_concat(' ',subclass) as str
	from player_specs
	inner join sub_classes
		on sub_classes.id = player_specs.sub_class_id
	group by player_id
	) as subcls
on  gen.id = subcls.id
inner join
	(
	# player specs w/ minimum iLVL
	select t1.pid as id, group_concat(' ',subclass) as name, t1.lvl as lvl
	from
	# minimum iLVL for each player
	(
		select player_id as pid, min(iLVL) as lvl
		from player_specs
		group by player_id
	) as t1
	inner join
	# joined w/ subclass name for that lvl
	(
		select player_id as pid, subclass, iLVL
		from player_specs
		inner join sub_classes
		on sub_classes.id = player_specs.sub_class_id
	) as t2
	on t1.pid = t2.pid and t1.lvl = t2.iLVL
    group by t1.pid
	) as min_lvls
on gen.id = min_lvls.id
inner join
	(
	# number of proffessions
	select player_id as id, count(proff_id) as num
	from player_proffs
	group by player_id
	) as n_proffs
on gen.id = n_proffs.id;


