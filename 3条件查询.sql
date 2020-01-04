# 条件查询
# 一、按条件表达式筛选
# 案例1：查询工资>12000的员工信息
select *
from employees
where salary > 12000;

# 案例2：查询部门编号不等于90号的员工名和部门编号 可以用<>或者!=
select last_name, department_id
from employees
where department_id <> 90;

# 二、按逻辑表达式筛选
# 案例1：查询工资在10000到20000之间的员工名、工资及奖金
select last_name, salary, commission_pct
from employees
where salary >= 10000
  and salary <= 20000;

# 案例2：查询部门编号不是在90到110之间，或者工资高于15000的员工信息
select *
from employees
where department_id < 90
   OR department_id > 110
   OR salary > 15000;

select *
from employees
where NOT (department_id >= 90 AND department_id <= 110)
   OR salary > 15000;

# 三、模糊查询
/*
    like:
    通配符：
        %：任意多个字符
        _：任意单个字符

 */
# 案例1：查询员工名中包含字符a的员工信息
select *
from employees
where last_name like '%a%';

# 案例2：查询员工名中第三个字符为n，第五个字符为l的员工名和工资
select last_name, salary
from employees
where last_name like '__n_l%';

# 案例3：查询员工名中第二个字符为_的员工名（转义字符）
# 方式1：默认\转义
select last_name
from employees
where last_name like '_\_%';
# 方式2：指定转义字符$
select last_name
from employees
where last_name like '_$_%' escape '$';

/*
     between and
     ①：使用between and 可以提高语句的简洁度
     ②：包含临界值
     ③：两个临界值不要调换顺序
 */
# 案例1：查询员工编号在100到120之间的员工信息
select *
from employees
where employee_id >= 100
  AND employee_id <= 120;

select *
from employees
where employee_id between 100 AND 120;

/*
    in
    用于判断某字段的值是否属于in列表中的某一项
    ①：使用in提高语句简洁度
    ②：in列表的值类型必须统一或兼容
    ③：
 */
# 案例：查询员工的工种编号是 IT_PROG、AD_VP、AD_PRES中的一个的员工名和工种编号
select last_name, job_id
from employees
where job_id in ('IT_PROG', 'AD_VP', 'AD_PRES');

/*
    is null / is not null
    = 或者 <> 不能用于判断null值
 */
# 案例1：查询没有奖金的员工名和奖金率
select last_name, commission_pct
from employees
where commission_pct is NULL;

/*
    安全等于    <=> 可以判断null值
 */
# 案例1：查询没有奖金的员工名和奖金率
select last_name, commission_pct
from employees
where commission_pct <=> null;
# 案例2：查询工资为12000的员工信息
select last_name, salary
from employees
where salary <=> 12000;

# 综合案例：
# 1. 查询工资大于12000的员工姓名和工资
select last_name, salary
from employees emp
where emp.salary > 12000;
# 2. 查询员工号为176的员工的姓名和部门号以及年薪
select last_name, department_id, salary * 12 * (1 + IFNULL(commission_pct, 0)) 年薪
from employees emp
where emp.employee_id = 176;
# 3. 选择工资不在5000到12000的员工的姓名和工资
select emp.last_name, emp.salary
from employees emp
where emp.salary not between 5000 and 12000;
# 4. 选择在20或50号部门工作的员工姓名和部门号
select emp.last_name, emp.department_id
from employees emp
where emp.employee_id between 20 and 50;
# 5. 选择公司中没有管理者的员工姓名及job_id
select emp.last_name, emp.job_id
from employees emp
where emp.manager_id is null;
# 6. 选择公司中有奖金的员工姓名、工资和奖金级别
select emp.last_name, emp.salary, emp.commission_pct
from employees emp
where emp.commission_pct is not null;
# 7. 选择员工姓名的第三个字母是a的员工姓名
select emp.last_name
from employees emp
where emp.last_name like '__a%';
# 8. 选择姓名中有字母a和e的员工姓名
select emp.last_name
from employees emp
where emp.last_name like '%a%'
   OR emp.last_name like '%e%';
# 9. 显示出表employee中first_name以'e'结尾的员工信息
select first_name, last_name
from employees
where first_name like '%e';
# 10. 显示出employee中部门编号在80-100之间的姓名和职位
select emp.last_name, emp.job_id
from employees emp
where emp.department_id between 80 and 100;
# 11. 显示出employee的manager_id是100,101,110的员工姓名、职位
select emp.last_name, emp.job_id
from employees emp
where emp.manager_id in (100, 101, 110);

# 一、查询没有奖金，工资小于18000的salary、last_name
select emp.salary, emp.last_name
from employees emp
where emp.commission_pct is null
  AND emp.salary < 1800;
# 二、 查询employees表中，job_id不为“IT”或者工资为12000的员工信息
select emp.last_name, emp.job_id, emp.salary
from employees emp
where emp.job_id != 'IT'
   OR emp.salary = 12000;
# 三、 查看部门departments表的结构
desc departments;
# 四、查询部门departments表中涉及到了哪些位置编号
select distinct location_id
from departments;
/*
 五、 经典面试题：
 试问： select * from employees
        和  select * from employees where commission_pct like '%%" and last_name like '%%';
        结果是否一样？说明原因
 */
select *
from employees;
select *
from employees
where commission_pct like '%%'
  and last_name like '%%';
# 答案是不一样，如果判断的值里有null值，则会不一样，如果都是or关键字就一样；

select distinct employee_id,last_name
from employees union (select employee_id,last_name from employees);