# 常见的约束
create database if not exists students;
use students;
# 一、创建表时添加约束
# 1.添加列级约束
create table if not exists major
(
    id        int primary key,
    majorName varchar(20)
);

create table if not exists stuinfo
(
    id      int primary key,# 主键
    stuName varchar(20) not null,# 非空
    gender  char(1) check ( gender = '男' or gender = '女' ),# 检查
    seat    int unique,# 唯一
    age     int default 18,# 默认约束
    majorId int references major (id)#外键约束
);

desc stuinfo;
# 查看stuinfo表中所有的索引，包括主键、外键、唯一
show index from stuinfo;

# 2. 添加表级约束
drop table if exists stuinfo;
create table stuinfo
(
    id      int,
    stuname varchar(20),
    gender  char(1),
    seat    int,
    age     int,
    majorId int,
    constraint pk_id primary key (id),# 主键
    constraint uq_seat unique (seat),# 唯一键
    constraint ck_gender check ( gender = '男' or gender = '女' ),# 检查
    constraint fk_stuinfo_major foreign key (majorId) references major (id)# 外键
);

show index from students.stuinfo;

# 二、修改表时添加约束
drop table if exists stuinfo;
create table stuinfo
(
    id      int,
    stuname varchar(20),
    gender  char(1),
    seat    int,
    age     int,
    majorId int
);
desc students.stuinfo;
# 1. 添加非空约束
alter table students.stuinfo
    modify column stuname varchar(20) not null;
# 2. 添加默认约束
alter table students.stuinfo
modify column age int default 18;
# 3. 添加主键
# ①：列级约束
alter table students.stuinfo modify column id int primary key ;
# ②：表级约束
alter table students.stuinfo add primary key (id);
# 4. 添加唯一
# ①：列级约束
alter table students.stuinfo modify column seat int unique ;
# ②：表级约束
alter table students.stuinfo add unique (seat);
# 5. 添加外键
# mysql只有表级生效
alter table students.stuinfo add foreign key (majorId) references major(id);
# 指定外键名字
alter table students.stuinfo add constraint fk_stuinfo_major foreign key (majorId) references major(id);

# 三、修改表时删除约束
# 1. 删除非空约束
alter table students.stuinfo modify column stuname varchar(20);
# 2. 删除默认约束
alter table students.stuinfo modify column age int;
# 3. 删除主键约束
alter table students.stuinfo modify column id int;
alter table students.stuinfo drop primary key ;
# 4. 删除唯一
alter table students.stuinfo drop index seat;
# 5. 删除外键
alter table students.stuinfo drop foreign key fk_stuinfo_major;