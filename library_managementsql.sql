-- Library management

-- creating branch table
Drop table if exists branch;
Create TABLE BRANCH (
	BRANCH_ID VARCHAR(10) primary key,
	MANAGER_ID VARCHAR(55),
	CONTACT_NO VARCHAR(10)
);

-- creating employees table
Drop table if exists employees;
CREATE TABLE EMPLOYEES (
	EMP_ID VARCHAR(10) PRIMARY KEY,
	EMP_NAME VARCHAR(25),
	POSITION varchar (15),
	SALARY INT,
	BRANCH_ID VARCHAR(25)
);

-- creating table books
Drop table if exists books;
CREATE TABLE BOOKS (
	ISBN VARCHAR(15) primary key,
	BOOK_TITLE VARCHAR(75),
	CATEGORY VARCHAR(10),
	RENTAL_PRICE FLOAT,
	STATUS VARCHAR(15),
	AUTHOR VARCHAR(35),
	PUBLISHER VARCHAR(55)
);
Alter table books
Alter column category type varchar(20);
Alter table books 
alter column isbn type varchar(20);

-- create table members
drop table if exists members;
CREATE TABLE MEMBERS (
	MEMBER_ID VARCHAR(10) PRIMARY KEY,
	MEMBER_NAME VARCHAR(25),
	MEMBER_ADDRESS VARCHAR(55),
	REG_DATE DATE
);

-- create table issue_status
drop table if exists issue_status;
CREATE TABLE ISSUE_STATUS (
	ISSUE_ID VARCHAR(10) primary key,
	ISSUED_MEMBER_ID VARCHAR(10),
	ISSUED_BOOK_NAME VARCHAR(75),
	ISSUED_DATE DATE,
	ISSUED_BOOK_ISBN VARCHAR(25),
	ISSUED_EMP_ID VARCHAR(10)
);

-- create table return_status
drop table if exists return_status;
CREATE TABLE RETURN_STATUS (
	RETURN_ID VARCHAR(10) PRIMARY KEY,
	ISSUED_ID VARCHAR(10),
	RETURN_BOOK_NAME VARCHAR(75),
	RETURN_DATE DATE,
	RETURN_BOOK_ISBN VARCHAR(20)
);

 Alter table issue_status
add constraint fk_members
foreign key (issued_member_id) references members(member_id);

alter table issue_status
add constraint fk_books
foreign key (issued_book_isbn) references books(isbn);

Alter table issue_status
Add Constraint fk_employees
foreign key(issued_emp_id)
References employees(emp_id);

alter table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id)

ALTER TABLE RETURN_STATUS
ADD CONSTRAINT FK_ISSUED_STATUS FOREIGN KEY (ISSUED_ID) REFERENCES ISSUE_STATUS (ISSUE_ID);

ALTER TABLE BRANCH
ADD COLUMN BRANCH_ADDRESS VARCHAR(10);

Alter table Branch 
alter column branch_address type VARCHAR(55);

Alter table branch 
alter column contact_no type varchar(20);


