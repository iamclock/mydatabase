


select concat(
'Сотрудник ', name,
' родился ', ДЕНЬ_РОЖДЕНИЯ МЕСЯЦ_РОЖДЕНИЯ_НАЗВАНИЕ ГОД_РОЖДЕНИЯ,
'. Сотрудник работает в отделе ', НАЗВАНИЕ_ОТДЕЛА,
' филиала г. ', НАЗВАНИЕ_ФИЛИАЛА, 'а',
' компании ', НАЗВАНИЕ_КОМПАНИИ,
', заработная плата сотрудника: ', ЗАРПЛАТА_СОТРУДНИКА,
'. В настоящий момент сотрудник ', if('находится в отпуске', 'не находится в отпуске'),
'. Отдел, в котором работает сотрудник оказывает ', КОЛИЧЕСТВО_УСЛУГ,
' услуг, количество других работников в отделе равно ', КОЛИЧЕСТВО_РАБОТНИКОВ_В_ОТДЕЛЕ, '.'
)# as request
from
company join branch_office on company.name = branch_office.idCompany
join office on office.idBranch = branch_office.id
join department on department.idOffice = Office.address
join employee on employee.idDepart = department.name
