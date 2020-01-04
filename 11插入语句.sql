# 插入语句
use girls;

# 语法1
# 1. 插入的值的类型要与列的类型一致或兼容
insert into beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
values (13, '唐艺昕', '女', '1990-4-23', '18988888888', null, 2);

# 2. 不可以为null的列必须要插入值，可以为null的列插入空值，或插入的时候不写该字段
# 方式1：
insert into beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
values (13, '唐艺昕', '女', '1990-4-23', '18988888888', null, 2);
# 方式2：
insert into beauty(id, name, sex, borndate, phone, boyfriend_id)
values (14, '金星', '女', '1990-4-23', '18888888888', 9);

# 3. 列的顺序可调换
insert into beauty(name, sex, id, phone)
values ('蒋欣','女','16',110);

# 4. 列数和值的个数必须一致
# 5. 可以省略列名，默认是所有列，而且列的顺序和表中列的顺序是一致的
insert into beauty values (18,'张飞','男',NULL,'119',NULL,NULL);
# 语法1支持插入多行
insert into beauty values (19,'刘备','男',NULL,'1219',NULL,NULL),(20,'关羽','男',NULL,'12219',NULL,NULL);
# 语法1支持子查询插入数据
insert into beauty (id,name,phone) select 26,'宋茜','1181233';

# 语法2
insert into beauty
set id = 21,name='刘涛',phone='999';
