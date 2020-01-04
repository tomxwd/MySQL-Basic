# 常见函数使用
use myemployees;

# 一、字符函数
# 1. length()：获取参数值的字节个数，utf-8一个中文3个字节
select length('john');
select length('张三丰hahaha');
show variables like '%char%';

# 2. concat 拼接字符串
select concat(last_name, '_', first_name) 姓名
from employees;

# 3. upper、lower 大小写转换
select upper('john');
select lower('JoHn');
select concat(upper(last_name), lower(first_name)) 姓名
from employees;

# 4. substr、substring 截取字符 4个重载，字符长度
select substr('李莫愁爱上了陆展元', 7) out_put;
select substr('李莫愁爱上了陆展元', 1, 3) out_put;
# 案例：姓名中首字符大写，其他字符小写，然后用下划线_拼接显示出来
select last_name, concat(upper(substr(last_name, 1, 1)), '_', lower(substr(last_name, 2))) 结果
from employees;

# 5. instr：返回子串第一次出现的位置，如果找不到就返回0
select instr('杨不悔爱上了殷六侠', '殷六侠');

# 6. trim：去前后空格
select length(trim('       张翠山     ')), trim('       张翠山     ') as out_put;
select trim('a' from 'aaaaaaaaaaaa张aaaaaaa翠山aaaaa') as out_put;

# 7. lpad：用指定的字符实现左填充指定长度，超过则截断
select lpad('殷素素', 10, '*') as out_put;

# 8. rpad：用指定的字符实现左填充指定长度，超过则截断
select rpad('殷素素', 12, 'ab') as out_put;

# 9. replace 所有都会替换
select replace('周芷若-张无忌爱上了周芷若', '周芷若', '赵敏') as out_put;

# 二、数学函数
# 1. round 四舍五入
select round(-1.65);
select round(1.567, 2);

# 2. ceil 向上取整，返回>=该参数的最小整数
select ceil(1.002); # 2
select ceil(-1.002);
# -1

# 3. floor 向下取整，返回<=该参数的最大整数
select floor(9.99); #9
select floor(-9.99);
# 10

# 4. truncate 截断    保留几位小数，直接截断
select truncate(1.65, 1);

# 5. mod取余  a%b a-a/b*b
select MOD(10, 3);# 1
select mod(-10, 3);
# -1

# 三、日期函数
# 1. now 返回当前系统日期+时间
select now();

# 2. curdate/current_date 返回当前系统日期，不包含时间
select curdate();
select current_date();

# 3. curtime/current_time 返回当前系统时间，不包含日期
select curtime();
select current_time();

# 4. year/month/day/hour/minute/second获取指定部分——年月日、时分秒
select year(now()) 年;
select month('1998-1-1') 年;
select year(hiredate)
from employees;
select month(hiredate)
from employees;
select MONTHNAME(hiredate)
from employees;

# 5. str_to_date：将日期格式的字符转换成指定格式的日期
select str_to_date('1998-3-2 1', '%Y-%c-%d %h');
# 案例：查询入职日期为1992-4-3的员工信息
select *
from employees
where hiredate = '1992-4-3';
select *
from employees
where hiredate = str_to_date('4-3 1992', '%c-%d %Y');

# 6. date_format：将日期转换成字符
select date_format(now(), '%Y年%m月%d日');
# 案例：查询有奖金的员工名和入职日期（xx月/xx日 xx年）
select last_name, DATE_FORMAT(hiredate, '%m月/%d日 %y年')
from employees
where commission_pct is not null;

# 四、其他函数
# 1. 查看当前数据库版本
select version();
# 2. 查看当前所在数据库
select database();
# 3. 当面用户
select user();

# 五、流程控制函数
# 1. if函数：类似三目运算符   表达式1结果为true则返回表达式2的值，false则返回表达式3的值
select if(10 < 5, '真', '假');
# 案例：有奖金则返回有，否则返回无
select last_name, commission_pct, if(commission_pct is null, '无奖金', '有奖金')
from employees;

# 2. case函数的使用一：switch case的效果
/*
    案例：查询员工的工资，要求
    部门号=30，显示的工资为1.1倍
    部门号=40，显示的工资为1.2倍
    部门号=50，显示的工资为1.3倍
    其他部门，显示的工资为原工资
 */
select salary,
       department_id,
       case department_id when 30 then salary * 1.1 when 40 then salary * 1.2 when 50 then salary * 1.3 else salary end
from employees;
# 3. case函数的使用二：类似于 if-else if-else
/*
    案例：查询员工的工资情况
    如果工资>20000，显示A级别
    如果工资>15000，显示B级别
    如果工资>10000，显示C级别
    否则，显示D级别
 */
select salary,
       case when salary > 20000 then 'A' when salary > 15000 then 'B' when salary > 10000 then 'C' else 'D' end
from employees;

# 综合测试
# 1. 显示系统时间（注：日期+时间）
select now();
# 2. 查询员工号、姓名、工资、工资提高百分之20%之后的结果
select employee_id, last_name, salary, salary * 1.2
from employees;
# 3. 将员工的姓名按首字母排序，并写出姓名的长度
select substr(last_name, 1, 1) 首字符, last_name, length(last_name)
from employees
order by 首字符;
/*
  4. 做一个查询，产生下面的结果：
  <last_name>earns<salary>monthly but wants<salary*3>
 */
select CONCAT(last_name, ' earns ', salary, ' monthly but wants ', salary * 3)
from employees;
/*
  5. 使用case-when，按照下面条件
    job_id      grade
    AD_PRES     A
    ST_MAN      B
    IT_PROG     C
    SA_REP      D
    ST_CLERK    E
 */
select last_name,
       job_id,
       case
           when job_id = 'AD_PRES' then 'A'
           when job_id = 'ST_MAN' then 'B'
           when job_id = 'IT_PROG' then 'C'
           when job_id = 'SA_REP' then 'D'
           when job_id = 'ST_CLERK' then 'E'
           end AS grade
from employees;
