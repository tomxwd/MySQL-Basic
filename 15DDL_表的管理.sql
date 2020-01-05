# 表的管理
use books;
# 1. 表的创建
# 创建book书籍表
create table book
(
    id          int,
    bName       varchar(20),
    price       double,
    authorId    int,
    publishDate datetime
);
desc book;
# 创建author作者表
create table author
(
    id      int,
    au_name varchar(20),
    nation  varchar(10)
);
desc author;

# 2.表的修改
# ① 修改列名
alter table book
    change column publishDate pubDate datetime;
# ② 修改列的类型或约束
alter table book
    modify column pubDate timestamp;
# ③ 添加新的列
alter table author
    add column annual double;
# ④ 删除列
alter table author
    drop column annual;
# ⑤ 修改表名
alter table authors rename to bok_authors;
alter table bok_authors rename to authors;
show tables;

# 3. 表的删除
drop table authors;
show tables;

# 4. 表的复制
insert into author (id, au_name, nation)
values (1, '村上春树', '日本'),
       (2, '莫言', '中国'),
       (3, '冯唐', '中国'),
       (4, '金庸', '中国');
# ①：仅仅复制表的结构
create table author_copy like author;
# ②：复制表的结构+数据
create table author_copy2
select *
from author_copy2;
# 复制部分列与部分数据
create table author_copy3
select id, au_name
from author
where nation = '中国';
