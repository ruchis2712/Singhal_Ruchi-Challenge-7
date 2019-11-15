-- Part 1 Q1: Number of [titles] Retiring &
-- Only the Most Recent Titles
SELECT emp_no, first_name, last_name, title, from_date, salary
	INTO recent_titles
FROM (
	SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, s.salary, 
	ROW_NUMBER() OVER (PARTITION BY e.emp_no ORDER BY t.from_date DESC) as rn
	FROM employees e
	RIGHT JOIN titles t on e.emp_no=t.emp_no
	RIGHT JOIN salaries s on e.emp_no=s.emp_no
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

