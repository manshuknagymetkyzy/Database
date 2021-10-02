-- 1a
select title from course where credits > 3;

-- 1b
select room_number from classroom where building = 'Watson' or building = 'Packard';

-- 1c
select title from course where dept_name = 'Comp. Sci.';

-- 1d
select title from course, section where course.course_id = section.course_id and section.semester = 'Fall';

-- 1e
select name from student where tot_cred > 45 and tot_cred < 90;

-- 1f
select name from student where name like '%a' or name like '%e' or name like '%i' or name like '%o' or name like '%u'
or name like '%y';

-- 1g
select title from course, prereq where course.course_id = prereq.course_id and prereq_id = 'CS-101';

-- 2a
select dept_name, avg(salary) as avg_salary from instructor group by dept_name order by avg_salary ASC;

-- 2b
select building from course, department where course.dept_name = department.dept_name group by building
having  count(*) = (select max(courses) from (
select count(*) as courses from department, course where department.dept_name = course.dept_name group by building)
as courses);

-- 2c
select dept_name from course group by dept_name having count(*) = (select min(courses) from(
select count(*) as courses from course group by dept_name) as courses);

-- 2d
select student.id, name from student, takes, course where takes.id = student.id and takes.course_id = course.course_id
and course.dept_name = 'Comp. Sci.' group by student.id, name having count('Comp. Sci') > 3;

-- 2e
select name from instructor where dept_name = 'Biology' or dept_name = 'Philosophy' or dept_name = 'Music';

-- 2f
select distinct name from instructor, teaches where instructor.id = teaches.id and year = '2018' and name not in (
select name from instructor, teaches where instructor.id = teaches.id and year = '2017');

-- 3a
select distinct name from student, takes, course where student.id = takes.id and takes.course_id = course.course_id and
course.dept_name = 'Comp. Sci.' and (takes.grade = 'A' or takes.grade = 'A-') order by name;

-- 3b
select distinct instructor.name from instructor, takes, student, advisor where instructor.id = advisor.i_id and
advisor.s_id = student.id and student.id = takes.id and (takes.grade = 'B-' or takes.grade like 'C%' or
takes.grade like 'D%' or takes.grade = 'F');

-- 3c
select distinct department.dept_name from department, student, takes where department.dept_name = student.dept_name and
student.id = takes.id and department.dept_name not in(select department.dept_name from department, student, takes
where department.dept_name = student.dept_name and student.id = takes.id and (takes.grade = 'F' or takes.grade = 'C'));

-- 3d
select distinct name from instructor, course, takes, advisor where instructor.id = advisor.i_id and takes.id = advisor.s_id
and course.course_id = takes.course_id and name not in (select name from instructor, course, takes, advisor
where instructor.id = advisor.i_id and takes.id = advisor.s_id and course.course_id = takes.course_id and takes.grade = 'A');

-- 3e
select title from course, section, time_slot where section.time_slot_id = time_slot.time_slot_id and
course.course_id = section.course_id and ((end_hr <= 13 and end_min = 0) or (end_hr <= 12 and end_min <= 59));