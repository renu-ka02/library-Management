-- performing CRUD operations on the data

-- task 1: Create a new book record
insert into books
values('978-1-60129-456-2','To kill a Mokingbird','classic',6.00,'yes','Harper lee','J.B. Lippincott & Co.');
select * from books;

-- Upadating an existing member address task
update members
set member_address = '125 Osk st'
where member_id ='C103';
select * from members;

-- Delete a record from issued Status table
delete  from issue_status
where issue_id='IS107';
select * from issue_status;

-- Retrive All books issued by a specific employee where emp_id='E101'
SELECT
	*
FROM
	ISSUE_STATUS
WHERE
	issued_emp_id = 'E101';

-- list members who have issued more than one book
select issued_member_id,count(issue_id) as total_books
from issue_status 
group by issued_member_id
having count(issue_id)>1;

-- Create Summary Tables
create table book_counts
as
select 
b.isbn,
b.book_title ,
count(ist.issue_id) as number_of_issued
from books as b
join issue_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;
select * from book_counts;

-- Retrive all books in Specific Category
select *
from books
where category='Fantasy';

-- Find the total Rental income by category
select category,sum(rental_price)  as total_rental_income
from books
group by category;

-- list the members who registered in the last 100 days
SELECT
	MEMBER_NAME,
	REG_DATE
FROM
	MEMBERS
ORDER BY
	REG_DATE DESC
LIMIT
	100;

-- list the employees with their branch Manager's Name and their  branch details
select e.emp_id,
e.emp_name,
e.position,
e.salary,
e.branch_id,
b.*
from employees e
join branch b
on b.branch_id = e.branch_id;

-- Create a table with Rental above a certain Threshold:
create table expensive as
Select * from books
where rental_price > 7.00;

-- Retrive the list of books not yet returned
select * from issue_status as ist
left join return_status rs
on rs.issued_id = ist.issue_id
where rs.return_id is null;

-- Advanced SQL Operations
-- identify members with overdue books
-- write a query to identy members who have overdue books 
select 
ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date,
current_date - ist.issued_date
from issue_status as ist
join 
members as m
on m.member_id = ist.issued_member_id
join 
books as bk
on bk.isbn = ist.issued_book_isbn
left join 
return_status as rs
on rs.issued_id = ist.issue_id
where 
rs.return_date is null
And (current_date - ist.issued_date) > 30
order by 1;

-- Create table for active members 
create table active_members as
select * from  members 
where member_id in (select 
distinct issued_member_id
from issue_status
where issued_date >= Current_date - interval '2 Month');

select * from active_members ;

-- employees With the most book issues processed
select
e.emp_name ,
b.*,
count(ist.issue_id) as no_book
from issue_status as ist
join 
employees as e 
on e.emp_id = ist.issued_emp_id
join 
branch as b
on e.branch_id = b.branch_id
group by 1,2

