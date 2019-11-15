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

3.) Who’s Ready for a Mentor?
  - Create a new table that contains the following information: Employee number, First and last name, Title, from_date and to_date
  - Note: The birth date needs to be between January 1, 1965 and December 31, 1965. Also, make sure only current employees are included in this list.
