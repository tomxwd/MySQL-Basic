# 联合查询
use myemployees;

#
select e.email,department_id
from employees e
union (select e.department_id,e.email from employees e);