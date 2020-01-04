# 排序查询
use myemployees;
# 案例1：查询员工信息，要求工资从高到低排序
select *
from employees emp
order by emp.salary desc;

# 案例2：查询部门编号>=90的员工信息，按入职时间的先后进行排序【添加了筛选条件】
select *
from employees emp
where emp.department_id >= 90
order by hiredate asc;

# 案例3：按年薪的高低显示员工的信息和年薪【按表达式排序】
select emp.*, emp.salary * 12 * (1 + ifnull(emp.commission_pct, 0)) year_salary
from employees emp
order by emp.salary * 12 * (1 + ifnull(emp.commission_pct, 0)) desc;

# 案例4：按年薪的高低显示员工的信息和年薪【按别名排序】
select emp.*, emp.salary * 12 * (1 + ifnull(emp.commission_pct, 0)) year_salary
from employees emp
order by year_salary desc;

# 案例5：按姓名的长度显示员工的姓名和工资【按函数排序】
select length(last_name) 字节长度, last_name, salary
from employees
order by 字节长度 desc;

# 案例6：查询员工信息，要求先按工资排序[升序]，再按员工编号排序[降序]【按多个字段排序】
select *
from employees
order by salary, employee_id desc;

# 测试
# 1. 查询员工的姓名和部门号以及年薪，按年薪降序、姓名升序
select last_name, department_id, salary * 12 * (1 + ifnull(commission_pct, 0)) 年薪
from employees
order by 年薪 desc, last_name asc;
# 2. 选择工资不再8000到17000的员工的姓名和工资，按工资降序
select last_name, salary
from employees e
where e.salary not between 8000 and 17000
order by salary desc;
# 3. 查询邮箱中包含e的员工信息，并先按邮箱的字节数降序，再按部门号升序
select *
from employees e
where e.email like '%e%'
order by length(e.email) desc, e.department_id;
