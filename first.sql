



create table if not exists parent(id int primary key auto_increment, cname varchar(255));
create table if not exists child(id int not null, cname set('one','two','three'), primary key(id), idparent int, foreign key fk_to_parent(idparent) references parent(id) on delete restrict on update cascade);
