# 库的管理
# 1. 库的创建
# 案例： 创建库books
create database books;
create database if not exists books;
show create database books;

# 2. 库的修改
# 案例：更改库的字符集
alter database books character set gbk;
show create database books;

# 3. 库的删除
drop database books;
drop database if exists books;
