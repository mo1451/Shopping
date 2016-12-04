--数据库命名全部小写

create database shopping;

use shopping;

create table user
(
id int primary key auto_increment,
username varchar(40),
password varchar(16),
phone varchar(40),
addr varchar(255),
rdate datetime
);

create table category
(
id int primary key auto_increment,
name varchar(255),
descr varchar(255),
pid int,
isleaf int, #0表示非leaf 1表示leaf
grade int
);

create table product
(
id int primary key auto_increment,
name varchar(255),
descr varchar(255),
normalprice double,
memberprice double,
pdate datetime,
category int references catetory(id)
);

create table salesorder
(
id int primary key auto_increment,
userid int,
addr varchar(255),
odate datetime,
status int
);

create table salesitem
(
id int primary key auto_increment,
productid int,
unitprice double,
pcount int,
orderid int
);