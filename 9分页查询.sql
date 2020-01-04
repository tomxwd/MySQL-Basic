# 分页查询
# 案例1：查询前五条员工信息
use myemployees;
select *
from employees
limit 0,5;
select *
from employees
limit 5;
# 案例2：查询11-25条
select *
from employees
limit 10,15;
# 案例3：有奖金的员工信息，工资降序，前10名
select *
from employees e
where e.commission_pct is not null
order by e.salary desc
limit 10;