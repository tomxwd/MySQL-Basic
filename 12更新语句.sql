# 更新语句
use girls;

# 1. 修改单表的记录
# 案例1：修改beauty表中姓唐的女神的电话为13898999898
update beauty set phone = '13898999898' where name like '唐%';

# 案例2：修改boys表中id号为2的名称为张飞，魅力值为10
update boys set boyName = '张飞', userCP = 10 where id='2';

# 2. 修改多表的记录
# 案例1：修改张无忌的女朋友的手机号为114
update boys bo
inner join beauty b on bo.id=b.boyfriend_id
set b.phone='114'
where bo.boyName='张无忌';
# 案例2：没有男朋友的女神的男朋友编号为2
update beauty b
left join boys bo on bo.id = b.boyfriend_id
set b.boyfriend_id = 2
where bo.id is null;
