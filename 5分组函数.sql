# 分组函数
use myemployees;

# 1. 简单使用
select sum(salary)
from employees;

select avg(salary)
from employees;

select min(salary)
from employees;

select max(salary)
from employees;

select count(*)
from employees e;

select sum(salary), avg(salary), max(salary), min(salary), count(salary)
from employees;

select sum(salary), round(avg(salary), 2), max(salary), min(salary), count(salary)
from employees;

# 2. 参数支持哪些类型
select sum(last_name), avg(last_name)
from employees;
select sum(hiredate), avg(hiredate)
from employees;
select max(last_name), min(last_name)
from employees;
select max(hiredate), min(hiredate)
from employees;
select count(commission_pct)
from employees;
select count(last_name)
from employees;

# 3. 是否忽略null值
select sum(commission_pct), avg(commission_pct), sum(commission_pct) / 35, sum(commission_pct) / 107
from employees;

select max(commission_pct), min(commission_pct)
from employees;

select count(commission_pct)
from employees;

# 4. 和distinct搭配使用
select sum(distinct salary), sum(salary)
from employees;

select count(distinct salary), count(salary)
from employees;

# 5. count函数的详细介绍
select count(salary)
from employees;

select count(*)
from employees;

select count(commission_pct)
from employees;

select count(1)
from employees;

# 6. 和分组函数一同查询的字段有限制
select avg(salary), employee_id
from employees;
# 逻辑错误

# 综合测试
# 1. 查询公司员工工资的最大值、最小值、平均值、总和
select max(salary), min(salary), avg(salary), sum(salary)
from employees;
# 2. 查询员工表中的最大入职时间和最小入职时间的相差天数（DATEDIFF）
select max(hiredate),min(hiredate),DATEDIFF(max(hiredate),min(hiredate))
from employees;
# 3. 查询部门编号为90的员工个数
select count(*)
from employees
where department_id=90;
