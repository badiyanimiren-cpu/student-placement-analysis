create database abcd;
use abcd;
select * from student_academic_placement_performance_dataset;

rename table student_academic_placement_performance_dataset to student_placement_dataset;

select student_id, count(*) as c
from student_placement_dataset
group by student_id
order by c desc;

/*
  Total students?
  Placement rate?
*/

SELECT 
    COUNT(*) AS total_students,
    SUM(placement_status) AS placed_students
FROM student_placement_dataset;

/*
 Placement %
*/ 

SELECT 
   round( SUM(placement_status)*100.0 / COUNT(*),2) AS placement_percentage
FROM student_placement_dataset;

/*
 Placement % for both placed and not placed
 */
  
SELECT 
 case 
  when placement_status = 1 then "placed"
  else "not_placed"
  end as status_ ,count(*) as total_student, count(*)*100/sum(count(*)) over() as percent 
FROM student_placement_dataset
group by status_;

/*
Backlogs Impact
*/

select count(student_id)as students , backlogs ,
count( case
when placement_status = 1 then placement_status
else null
end) as placed
from student_placement_dataset
group by backlogs
order by backlogs;
 /*
  Internship,Live Projects and Cgpa Impact
  */

select internship_count,live_projects,cgpa,placement_status
from student_placement_dataset
order by placement_status desc,internship_count,live_projects;

/*
Top 10% Students by Salary
*/

SELECT student_id, salary_package_lpa,
           rank() OVER (ORDER BY salary_package_lpa DESC) AS salary_rank
    FROM student_placement_dataset
    WHERE placement_status = 1
    limit 10;
    
    /*
    Internships Impact
    */
    
    SELECT internship_count,
       COUNT(*) AS students,
       SUM(placement_status) AS placed
FROM student_placement_dataset
GROUP BY internship_count
ORDER BY internship_count;





