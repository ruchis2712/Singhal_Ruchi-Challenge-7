# Challenge 7
## Postgres SQL

## Project Summary:
The project is to create employee related tables (such as employee, salaries, titles etc.) in the database, import data from csv files into the tables and write SQL statements to answer the following questions:

1. Number of [titles] Retiring

2. Only the Most Recent Titles

3. Who’s Ready for a Mentor?

The instructions provided for this project are to create a new list of potential mentors. To do this you will need to create a query that returns a list of current employees eligible for retirement, as well as their most recent titles. To get the final list with the recent titles, you’ll also need to partition the data so that each employee is only included on the list once. In addition, you’ll need to perform a query that shows how many current employees of each title are presently eligible for retirement. The final query should return the potential mentor’s employee number, first and last name, their title, birth date and employment dates.

### Given below is the ERD for the project database
![ERD for the Project](https://github.com/ruchis2712/Singhal_Ruchi-Challenge-7/blob/master/ERD.png)

### Questions and their related SQL statements and sample output
1.) Number of [titles] Retiring
  - Create a new table using a RIGHT JOIN that contains the following information: Employee number, First and last name, Title, from_date, Salary
  - Export the data as a CSV.

2.) Only the Most Recent Titles
  - Exclude the rows of data containing duplicate titles using Partitioning Your Data
  - In descending order (by date), list the frequency count of employee titles (i.e., how many employees share the same title?)
  - Export the data as a CSV.
  
#### SQL for Q1 & Q2
SELECT emp_no, first_name, last_name, title, from_date, salary
	INTO recent_titles
FROM (
	SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, s.salary, 
	ROW_NUMBER() OVER (PARTITION BY e.emp_no ORDER BY t.from_date DESC) as rn
	FROM employees e
	RIGHT JOIN titles t on e.emp_no=t.emp_no
	RIGHT JOIN salaries s on e.emp_no=s.emp_no
  WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
) tmp WHERE rn=1;

-- Part 1 Q2: In descending order (by date), list the frequency count of employee titles (i.e., how many employees share the same title?).

SELECT p.*, t.title_count 
	INTO OUTFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\part1_q2.csv"
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
FROM recent_titles p 
INNER JOIN (SELECT title, COUNT(*) AS title_count FROM recent_titles GROUP BY title) AS t 
ON p.title=t.title ORDER BY p.from_date DESC;

### OUTPUT: outputs in csv files part1-q1.csv and part1_q2.csv within the repo
  - 90,398 epmloyees are retiring across 7 different titles
  - Largest number of retirees belong to Senior Engineer title
  
    Titles:Count of retirees
    
    Senior Engineer : 29,415 
    
    Senior Staff : 28,255 
    
    Engineer : 14,221 
    
    Staff : 12,242 
    
    Technique Leader : 4,500 
    
    Assistant Engineer : 1,761 
    
    Manager : 4 
    

3.) Who’s Ready for a Mentor?
  - Create a new table that contains the following information: Employee number, First and last name, Title, from_date and to_date
  - Note: The birth date needs to be between January 1, 1965 and December 31, 1965. Also, make sure only current employees are included in this list.

#### SQL for Q3
-- Part 1 Q3: Who’s Ready for a Mentor?

SELECT e.emp_no, e.first_name, e.last_name, t.title, d.from_date, d.to_date
	INTO OUTFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\part1_q3.csv"
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
FROM employees e 
INNER JOIN dept_employee d ON e.emp_no=d.emp_no
INNER JOIN titles t ON e.emp_no=t.emp_no
WHERE (d.to_date='9999-01-01') -- looking for current employees
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

### OUTPUT: outputs in csv files part1-q3.csv within the repo
  - 2,382 current employees are available for mentorship role
  
## RECOMMENDATION for further analysis on this dataset
  - By titles count of the number of employees available for mentorship role. To enable narrowing down the list to the most eligible mentors
  - Narrow the list of retirees (retiring titles in part 1 Q1 & Q2) to only include current employees
