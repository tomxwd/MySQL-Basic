# 常见数据类型
# 1.如何设置无符号和有符号
drop table if exists tab_int;
create table tab_int(
    t1 int,
    t2 int unsigned
);
desc tab_int;