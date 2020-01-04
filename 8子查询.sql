use myemployees;
# 子查询

# 一、where或having后面
# 1. 标量子查询（单行子查询）
# 案例1：谁的工资比Abel高？
select e.last_name, e.salary
from employees e
where salary > (select e.salary
                from employees e
                where e.last_name = 'Abel');
# 案例2：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
select e.last_name, e.job_id, e.salary
from employees e
where e.job_id = (select e.job_id from employees e where e.employee_id = 141)
  and e.salary > (select e.salary from employees e where e.employee_id = 143);
# 案例3：返回公司工资最少的员工的last_name,job_id和salary
select e.last_name, e.job_id, e.salary
from employees e
where e.salary = (select min(e.salary)
                  from employees e);
# 案例4：查询最低工资>50号部门最低工资的部门id和其最低工资
select e.department_id, min(salary)
from employees e
group by e.department_id
having min(e.salary) > (select min(salary)
                        from employees
                        where department_id = 50);

# 2. 列子查询（多行）
# 案例1：返回location_id是1400或1700的部门中所有员工的姓名
select e.last_name
from employees e
where e.department_id in (select d.department_id
                          from departments d
                          where d.location_id in (1400, 1700));
# 案例2：返回其他工种中比job_id为“IT_PROG”工种任一工资低的员工的员工号、姓名、job_id以及salary
select e.employee_id, e.last_name, e.job_id, e.salary
from employees e
where e.job_id != 'IT_PROG'
  AND e.salary < any (select distinct salary
                      from employees e
                      where e.job_id = 'IT_PROG');
select e.employee_id, e.last_name, e.job_id, e.salary
from employees e
where e.job_id != 'IT_PROG'
  AND e.salary < (select max(e.salary)
                  from employees e
                  where e.job_id = 'IT_PROG');
# 案例3：返回其他工种中比job_id为“IT_PROG"部门所有工资都低的员工的员工号、姓名、job_id以及salary
select e.employee_id, e.last_name, e.job_id, e.salary
from employees e
where e.job_id != 'IT_PROG'
  AND e.salary < all (
    select distinct e.salary
    from employees e
    where e.job_id = 'IT_PROG');
select e.employee_id, e.last_name, e.job_id, e.salary
from employees e
where e.job_id != 'IT_PROG'
  AND e.salary < (
    select min(e.salary)
    from employees e
    where e.job_id = 'IT_PROG');

# 3. 行子查询（一行多列或多列多行）
# 案例1：查询员工编号最小并且工资最高的员工信息
select *
from employees
where employee_id = (select min(e.employee_id)
                     from employees e)
  AND salary = (select max(salary)
                from employees e);

select *
from employees e
where (e.employee_id, e.salary) = (select min(employee_id), max(salary) from employees e);

# 二、select后面
# 案例1：查询每个部门的员工个数
select d.*,
       (
           select count(*)
           from employees e
           where e.department_id = d.department_id
       )
from departments d;
# 案例2：查询员工号为102的部门名
select e.employee_id, (select d.department_name from departments d where e.department_id = d.department_id)
from employees e
where e.employee_id = '102';

# 三、from后面
# 案例1：查询每个部门的平均工资的工资等级
select e.*, jg.grade_level
from (select avg(e.salary) salary, department_id
      from employees e
      group by e.department_id) e
         left join job_grades jg
                   on e.salary between jg.lowest_sal and jg.highest_sal;

# 四、exists后面（相关子查询）
# 案例1：查询有员工名的部门名
# exists
select d.department_name
from departments d
where exists(select * from employees e where e.department_id = d.department_id)
# in
select d.department_name
from departments d
where d.department_id in (
    select e.department_id
    from employees e);

# 综合测试
# 1. 查询和Zlotkey相同部门的员工姓名和工资
select e.last_name, e.salary
from employees e
where e.department_id = (select e.department_id from employees e where e.last_name = 'Zlotkey');
# 2. 查询工资比公司平均工资高的员工的员工号，姓名和工资
select e.employee_id, e.last_name, e.salary
from employees e
where e.salary > (select avg(salary)
                  from employees);
# 3. 查询各部门中工资比本部门平均工资高的员工的员工号、姓名和工资
select e.employee_id, e.last_name, e.salary, d.avg_salary, e.department_id
from employees e
         left join (select e.department_id, avg(e.salary) avg_salary
                    from employees e
                    group by e.department_id) d
                   on e.department_id = d.department_id
where e.salary > d.avg_salary;
# 4. 查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
select e.employee_id, e.last_name
from employees e
where e.department_id in (
    select distinct e.department_id
    from employees e
    where e.last_name like '%u%')
  and e.last_name not like '%u%';
# 5. 查询在部门的location_id为1700的部门工作的员工的员工号
select e.employee_id
from employees e
where e.department_id in (
    select distinct d.department_id
    from departments d
    where d.location_id = 1700);
# 6. 查询管理者是K_ing的员工姓名和工资
select e.last_name, e.salary
from employees e
where e.manager_id in (select e.employee_id from employees e where e.last_name = 'K_ing');
# 7. 查询工资最高的员工的姓名，要求first_name和last_name显示为一列，列名为姓.名
select concat(e.first_name, '.', e.last_name)
from employees e
where e.salary = (select max(e.salary) max_salary from employees e);

# 子查询经典案例
# 1. 查询工资最低的员工信息：last_name,salary
select last_name, salary
from employees e
where e.salary = (select min(salary) from employees);
# 2. 查询平均工资最低的部门信息
select *
from departments d
where d.department_id = (select e.department_id
                         from employees e
                         group by e.department_id
                         order by avg(e.salary)
                         limit 1);
# 3. 查询平均工资最低的部门信息和该部门的平均工资
select *
from departments d
         inner join (select e.department_id, avg(e.salary)
                     from employees e
                     group by e.department_id
                     order by avg(e.salary)
                     limit 1) a
                    on d.department_id = a.department_id;
# 4. 查询平均工资最高的job信息
select *
from jobs j
where j.job_id = (select e.job_id
                  from employees e
                  group by e.job_id
                  order by avg(e.salary) desc
                  limit 1);
# 5. 查询平均工资高于公司平均工资的部门有哪些？
select department_id, avg(salary)
from employees e
group by e.department_id
having avg(salary) > (select avg(salary) from employees);
# 6. 查询出公司中所有manager的详细信息
select distinct m.*
from employees e
         inner join employees m
                    on e.manager_id = m.employee_id;
# 7. 各个部门中最高工资中最低的那个部门，最低工资是多少
select max(e.salary),e.department_id
from employees e
group by e.department_id
order by max(e.salary) limit 1;
# 8. 查询平均工资最高的部门的manager的详细信息：last_name,department_id,email,salary
select e.*
from departments d
         right join (select e.department_id, avg(e.salary)
                     from employees e
                     group by e.department_id
                     order by avg(e.salary) desc
                     limit 1) s
                    on d.department_id = s.department_id
         left join employees e on e.employee_id = d.manager_id;