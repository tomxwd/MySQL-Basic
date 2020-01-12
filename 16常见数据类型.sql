# 常见数据类型

# 一、整数
# 1.如何设置无符号和有符号
drop table if exists tab_int;
create table tab_int
(
    t1 int,
    t2 int unsigned
);
desc tab_int;

# 二、小数
/*
     1. 浮点型
     - float
     - double
     2. 定点型
     - DEC(M,D) / DECTMAL(M,D)
 */

create table tab_float
(
    d1 float,
    d2 double,
    d3 decimal,
    f1 float(5, 2),
    f2 double(5, 2),
    f3 decimal(5, 2)
);

desc tab_float;
# 测试插入数据
insert into tab_float (f1, f2, f3)
values (1230.00, 124.153, 133.343);
# 查询表数据
select *
from tab_float;

# 三、字符型
# 枚举Enum(不区分大小写)
create table tab_char
(
    c1 ENUM ('a','b','c')
);

insert into tab_char
values ('a');
insert into tab_char
values ('b');
insert into tab_char
values ('c');
insert into tab_char
values ('m');
insert into tab_char
values ('A');

select *
from tab_char;

# 集合SET（不区分大小写）
create table tab_set
(
    s1 set ('a','b','c','d')
);

insert into tab_set
values ('a');
insert into tab_set
values ('a,b');
insert into tab_set
values ('a,b,d');
insert into tab_set
values ('a,b,d');
insert into tab_set
values ('a,b,e');

select *
from tab_set;

# 四、日期型
create table tab_date
(
    t1 datetime,
    t2 timestamp
);

insert into tab_date
values (now(), now());

select *
from tab_date;
# 查看时区
show variables like 'time_zone';
# 更改时区
set time_zone = '+8:00';
# 再次查询数据
select *
from tab_date;