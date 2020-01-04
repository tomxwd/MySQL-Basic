# 1. 查询表中的字段
select last_name
from employees;
# 2. 查询表中的多个字段
select last_name, salary, email
from employees;
# 3. 查询表中的所有字段
select employee_id,
       first_name,
       last_name,
       email,
       phone_number,
       job_id,
       salary,
       commission_pct,
       manager_id,
       department_id,
       hiredate
from employees;

select *
from employees;

# 4. 查询常量值
select 100;
select 'john';

# 5. 查询表达式
select 100 % 98;

# 6. 查询函数
select VERSION();

# 7. 起别名
# 方式1 使用as
select 100 % 98 AS 结果;
select last_name AS 姓, first_name AS 名
from employees;
# 方式2 使用空格
select last_name 姓, first_name 名
from employees;
# 案例：查询salary，显示结果为out put
select salary as "out put"
from employees;

# 8. 去重
# 案例：查询员工表中涉及到的所有部门编号
select distinct department_id
from employees;

# 9. 加号（+）的作用
/*
 java中的+号：
 ①：运算符，两个操作数都为数值型
 ②：连接符，只要有一个操作数为字符串

 mysql中的+号
 仅仅有一个功能，就是运算符
 select 100+90; 两个操作数为数值型，则做加法运算
 select '123'+90; 其中一方为字符型，试图将字符型数值转换成数值型，如果转换成功，则继续做加法运算
 select 'john'+90; 如果转换失败，则将字符型转换为0
 select null+10; 只要其中一方为null，则结果肯定为null
 */
# 案例：查询员工名和姓连接成一个字段，并显示为姓名
select CONCAT('a', 'b', 'c') AS 结果;
select concat(last_name, first_name) as 姓名
from employees;

