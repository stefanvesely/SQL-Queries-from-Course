SELECT first_name, title, grade from students inner join papers where papers.student_id = students.id;

SELECT first_name, title, grade from students left join papers on papers.student_id = students.id;

SELECT first_name, ifnull( title, 'dead'), ifnull( grade, 0) from students left join papers on papers.student_id = students.id;

SELECT first_name,ifnull( avg(grade), 0) as grade from papers right join students on papers.student_id = students.id group by students.id order by grade desc;


SELECT first_name,ifnull( avg(grade), 0) as grade,
CASE
    when avg(grade) is null then 'fail'
    when avg(grade) >= 75 then 'pass'
else 'fail' end as passing_stats
from papers right join students on papers.student_id = students.id group by students.id order by grade desc;