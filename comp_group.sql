




create table if not exists company(name varchar(255) primary key);
create table if not exists office(address varchar(255) primary key, idBranch int, foreign key fk_to_branch(idBranch) references branch_office());
create table if not exists client();
create table if not exists employee();
create table if not exists department(name varchar(255) primary key, phone_number varchar(11) unique, );
create table if not exists service();
create table if not exists oredered_service();
create table if not exists branch_office();
create table if not exists claim();