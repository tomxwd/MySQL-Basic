# 连接查询
use girls;

# 直接查询两个表，没加任何条件，会造成笛卡尔积的错误情况【完全连接】
select name, boyName
from boys,
     beauty;

select name, boyName
from boys,
     beauty
where beauty.boyfriend_id = boys.id;

# 一、sql92标准
# 1. 等值连接
# 案例1：查询女神名和对应的男神名
select beauty.name, boys.boyName
from boys,
     beauty
where boys.id = beauty.boyfriend_id;

# 案例2：查询员工名和对应的部门名
select e.last_name, d.department_name
from employees e,
     departments d
where e.department_id = d.department_id;

# 案例3：查询员工名、工种编号、工种名
select e.last_name, e.job_id, j.job_title
from employees e,
     jobs j
where e.job_id = j.job_id;

# 案例4：查询有奖金的员工名、部门名【加筛选条件】
select e.last_name, d.department_name
from employees e,
     departments d
where e.department_id = d.department_id
  and e.commission_pct is not null;

# 案例5：查询城市中第二个字符为o的部门名和城市名【加筛选条件】
select d.department_name, l.city
from locations l,
     departments d
where d.location_id = l.location_id
  and l.city like '_o%';

# 案例6：查询每个城市的部门个数【加分组】
select city, count(*)
from locations l,
     departments d
where l.location_id = d.location_id
group by l.city;

# 案例7：查询有奖金的每个部门的部门名以及部门的领导编号,以及该部门的最低工资【加分组】
select d.department_name, d.manager_id, min(e.salary)
from employees e,
     departments d
where e.department_id = d.department_id
  and e.commission_pct is not null
group by d.department_name, d.manager_id;

# 案例8：查询每个工种的工种名和员工的个数，并且按员工的个数降序【加排序】
select j.job_title, count(*)
from jobs j,
     employees e
where e.job_id = j.job_id
group by j.job_title
order by count(*) desc;

# 案例9：查询员工名，部门名，所在城市【三表查询】
select e.last_name, d.department_name, l.city
from employees e,
     departments d,
     locations l
where e.department_id = d.department_id
  and d.location_id = l.location_id;

# 2. 非等值连接
# 案例1：查询员工的工资和工资级别
select e.last_name, e.salary, j.grade_level
from employees e,
     job_grades j
where e.salary between j.lowest_sal and j.highest_sal;

# 3. 自连接
# 案例：查询员工名以及其上级的名字
select e.last_name, m.last_name
from employees e,
     employees m
where e.manager_id = m.employee_id;

# 综合测试 1
# 1. 显示员工表中的最大工资、工资平均值
select max(salary), avg(salary)
from employees;
# 2. 查询员工表的employee_id，job_id，last_name，按department_id降序，salary升序
select employee_id, job_id, last_name
from employees
order by department_id desc, salary asc;
# 3. 查询员工表的job_id包含a和e的，并且a在e前面
select job_id
from employees
where job_id like '%a%e%';
/*
  4. 已知表student，有id（学号），name，gradeId（年级编号）
         表grade，有id（年级编号），name（年级名）
         表result，有id，score，studentNo（学号）
     要求查询姓名、年级名、成绩
    select s.name,g.name,r.score
    from student s,
         grade g,
         result r
    where s.gradeId = g.id and s.id = r.studentNo;
 */
# 5. 显示当前日期，以及去前后空格，截取子字符串的函数
select now(), trim('   123  '), substr('123456', 3);

# 综合测试 2
# 1. 显示所有员工的姓名，部门号和部门名称
select e.last_name, e.department_id, d.department_name
from employees e,
     departments d
where e.department_id = d.department_id;
# 2. 查询90号部门员工的job_id和90号部门location_id
select e.job_id, d.location_id
from employees e,
     departments d
where e.department_id = d.department_id
  and e.department_id = 90;
# 3. 选择所有有奖金的员工的 last_name,department_name,location_id,city
select e.last_name, d.department_name, d.location_id, l.city
from employees e,
     departments d,
     locations l
where e.department_id = d.department_id
  and d.location_id = l.location_id
  and e.commission_pct is not null;
# 4. 选择city在Toronto工作的员工的last_name,job_id,department_id,department_name
select e.last_name, e.job_id, d.department_id, d.department_name
from employees e,
     departments d,
     locations l
where e.department_id = d.department_id
  and d.location_id = l.location_id
  and l.city = 'Toronto';
# 5. 查询每个工种、每个部门的部门名、工种名和最低工资
select d.department_name, j.job_title, min(e.salary)
from employees e,
     departments d,
     jobs j
where e.department_id = d.department_id
  and e.job_id = j.job_id
group by j.job_id, d.department_name;
# 6. 查询每个国家下的部门个数大于2的国家编号
select l.country_id, count(*)
from locations l,
     departments d
where d.location_id = l.location_id
group by l.country_id
having count(*) > 2;
# 7. 选择指定员工的姓名、员工号、管理者的姓名和员工号
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e,
     employees m
where e.manager_id = m.employee_id;


# 二、sql99标准
# 1. 内连接
# 【内连接】 等值连接
# 案例1：查询员工名、部门名
select *
from employees e
         inner join departments d on e.department_id = d.department_id;
# 案例2：查询名字中包含e的员工名和工种名（筛选）
select e.last_name, j.job_title
from employees e
         inner join jobs j on e.job_id = j.job_id
where e.last_name like '%e%';
# 案例3：查询部门个数>3的城市名和部门个数（分组+筛选）
select l.city, count(*)
from departments d
         inner join locations l on d.location_id = l.location_id
group by l.city
having count(*) > 3;
# 案例4：查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序（排序）
select d.department_name, count(*)
from employees e
         inner join departments d on e.department_id = d.department_id
group by e.department_id
having count(*) > 3
order by count(*) desc;
# 案例5：查询员工名、部门名、工种名，并按部门名降序
select e.last_name, d.department_name, j.job_title
from employees e
         inner join departments d on e.department_id = d.department_id
         inner join jobs j on e.job_id = j.job_id
order by d.department_name desc;

# 【内连接】非等值连接
# 案例1：查询员工的工资级别
select e.last_name, e.salary, jg.grade_level
from employees e
         inner join job_grades jg
                    on e.salary between jg.lowest_sal and jg.highest_sal;
# 案例2：查询每个工资级别的个数>20，并且按工资级别的降序
select count(*), jg.grade_level
from employees e
         inner join job_grades jg
                    on e.salary between jg.lowest_sal and jg.highest_sal
group by jg.grade_level
having count(*) > 20
order by jg.grade_level desc;

# 【内连接】自连接
# 案例1：查询员工的姓名、上级的名字
select e.last_name, m.last_name
from employees e
         inner join employees m on e.manager_id = m.employee_id;
# 案例2：查询姓名包含k的员工、上级的名字
select e.last_name, m.last_name
from employees e
         inner join employees m on e.manager_id = m.employee_id
where e.last_name like '%k%';

# 2. 外连接
# 引入：查询男朋友不在男神表的女神名
use girls;
#           左外连接实现
select g.name
from beauty g
         left outer join boys b on g.boyfriend_id = b.id
where b.id is null;
#           右外连接实现
select g.name
from boys b
         right outer join beauty g on b.id = g.boyfriend_id
where b.id is null;

use myemployees;
# 案例1：查询哪个部门没有员工
select d.department_name, e.employee_id
from departments d
         left outer join employees e on d.department_id = e.department_id
where e.employee_id is null;

# 4. 交叉连接
select *
from beauty b
         cross join boys bo;

# 综合案例
# 1. 查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有则null填充
select g.*, b.*
from beauty g
         left outer join boys b
                         on g.boyfriend_id = b.id
where g.id > 3;

# 2. 查询哪个城市没有部门
use myemployees;
select l.city
from departments d
         left outer join locations l on l.location_id = d.location_id
where d.department_id is null;

# 3. 查询部门名为SAL或IT的员工信息
select e.last_name, d.department_id, d.department_name
from departments d
         left join employees e on e.department_id = d.department_id
where d.department_name = 'SAL'
   OR d.department_name = 'IT';