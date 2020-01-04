# 三、 删除语句
use girls;

# 方式1：delete
# 1. 单表的删除
# 案例1： 删除手机号以9结尾的女神信息
delete
from beauty
where phone like '%9';
select *
from beauty;
select *
from boys;
# 2. 多表的删除
# 案例2：删除张无忌的女朋友的信息
delete b
from beauty b
         inner join boys bo on b.boyfriend_id = bo.id
where bo.boyName = '张无忌';
# 案例3：删除黄晓明的信息以及女朋友的信息
delete b,bo
from beauty b
         inner join boys bo on b.boyfriend_id = bo.id
where bo.boyName = '黄晓明';

# 方式2：truncate语句
# 案例：清空表数据
truncate table boys;
