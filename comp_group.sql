



create database if not exists new_2015;
use new_2015;
create table if not exists company(name varchar(255) primary key);
create table if not exists _order(
									id int not null auto_increment,
									submission_date date not null,
									primary key (id)
									);
create table if not exists claim(
									id int not null auto_increment,
									commentary varchar(255) not null,
									idOrder int not null,
									foreign key fk_to_order(idOrder) references _order(id),
									primary key (id)
									);
create table if not exists client(
									name varchar(255) not null,
									id int not null auto_increment,
									idOrder int not null,
									bday date not null,
									priority int,
									foreign key fk_to_order(idOrder) references _order(id),
									primary key (id)
									);
create table if not exists branch_office(
									city_name varchar(255) not null,
									id int not null,
									idCompany varchar(255) not null,
									foreign key fk_to_company(idCompany) references company(name),
									primary key (id)
									);
create table if not exists office(
									address varchar(255),
									idBranch int not null,
									head_office bool,
									main_office bool,
									foreign key fk_to_branch(idBranch) references branch_office(id),
									primary key (address)
									);
create table if not exists department(
									name varchar(255) not null,
									phone_number varchar(11),
									idOffice varchar(255) not null,
									unique key (phone_number),
									foreign key fk_to_office(idOffice) references office(address),
									primary key(name)
									);
create table if not exists employee(
									name varchar(255) not null,
									post varchar(255) not null,
									id int not null auto_increment,
									vacancy bool, -- возможно лучше поставить дату или число дней
									idDepart varchar(255) not null,
									bday date not null,
									foreign key fk_to_department(idDepart) references department(name),
									primary key (id)
									);
create table if not exists service(
									name varchar(255) not null,
									cost int,
									idDepart varchar(255) not null,
									id int not null,
									foreign key fk_to_depart(idDepart) references department(name),
									primary key (id)
									);