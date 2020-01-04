# 分组查询
use myemployees;

select department_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id;

# 简单的分组查询
# 案例1：查询每个工种的最高工资
select max(salary), job_id
from employees
group by job_id;

# 案例2：查询每个位置上的部门个数
select count(*), location_id
from departments
group by location_id;

# 添加分组前的筛选条件
# 案例1：查询邮箱中包含a字符的，每个部门的平均工资
select department_id, avg(salary)
from employees
where email like '%a'
group by department_id;

# 案例2：查询有奖金的每个领导手下员工的最高工资
select max(salary), manager_id
from employees
where commission_pct is not null
group by manager_id;

# 添加分组后的筛选条件
# 案例1：查询哪个部门的员工个数>2
# ①：查询每个部门的员工个数
select department_id, count(*)
from employees
group by department_id;
# ②：根据①得到的结果进行筛选，查询哪些部门的员工个数>2
select department_id, count(*)
from employees
group by department_id
having count(*) > 2;

# 案例2：查询每个工种有奖金的员工，且最高工资>12000的工种编号和最高工资
select job_id, max(salary)
from employees
where commission_pct is not null
group by job_id
having max(salary) > 12000;

# 案例3：领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及其最低工资
select manager_id, min(salary)
from employees
where manager_id > 102
group by manager_id
having min(salary) > 5000;

# 按表达式或函数分组
# 案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些
select length(last_name), count(*)
from employees
group by length(last_name)
having count(*) > 5;

# 按多个字段分组
# 案例：查询每个部门每个工种的员工的平均工资
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

# 添加排序
## 案例：查询每个部门每个工种的员工的平均工资，部门不为null且平均工资高于10000，并且按平均工资的降序排序
select department_id, job_id, avg(salary)
from employees
where department_id is not null
group by department_id, job_id
having avg(salary) > 10000
order by avg(salary) desc;

# 综合测试
# 1. 查询各个job_id的员工工资的最大值、最小值、平均值、总和，并按job_id排序
select job_id, max(salary), min(salary), avg(salary), sum(salary)
from employees
group by job_id
order by job_id;
# 2. 查询员工最高工资和最低工资的差距
select max(salary) - min(salary)
from employees;
# 3. 查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000;
# 4. 查询所有部门的编号，员工数量和工资平均值，并按平均工资降序排序
select department_id, count(*), avg(salary)
from employees
group by department_id;
# 5. 选择各个job_id的员工人数
select count(*),job_id
from employees
group by job_id;