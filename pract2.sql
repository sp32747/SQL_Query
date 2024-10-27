select *from student;
select *from details;
select *from marks;

select s_name, score, status, address_city, email_id,
accomplishments from student s inner join marks m on
s.s_id = m.s_id inner join details d on 
d.school_id = m.school_id;

select s_name, score, status, address_city, 
email_id, accomplishments from student s, 
marks m, details d where s.s_id = m.s_id and 
m.school_id = d.school_id;

