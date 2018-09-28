<!--
-- 데이터베이스 이름 : testdb
-->


create table testboard(
num int not null auto_increment,
title varchar(200) not null,
writer varchar(50) not null,
content varchar(500) not null,
pwd varchar(8) not null,
regdate date not null,
primary key(num)
);
