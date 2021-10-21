select * from authors;

select * from titles;

select * from titles where price is null;

select price, coalesce(price::numeric ,20.00) from titles t;

select substring(pr_info for 50) from pub_info pi2 ; 

select to_char(pubdate, 'yyyy- mm - dd') from titles t ; 

select pubdate, cast (pubdate as varchar) from titles ;

select * from pubs2.sales s ;


select to_char(ord_date ::date , 'day ddth month yyyy') from sales s ;


--printing the current date 
select current_date ;


--displaying current time
select current_time ;

--displaying current timestamp 

select current_timestamp ;

--converting a string to date ,takes the string of date and the format

select to_date('2018-09-26','yyyy-mm-dd') ;

--subtracting two dates
select  cast('2018-12-25' as date) - cast('2018-09-26' as date) as "time difference";

--number of days elasped since each book in Titles was published


--************************************************
--                 day two labs
--************************************************

--Get average prices from the titles table for each type of book, and convert type to char(30)

select type, avg(price :: numeric ) :: char(30) from titles t 
group by "type" ;

--Print the difference between (to a resolution of days) the earliest and latest publication date in titles

select max(pubdate) - min(pubdate) as "difference between earliest and latest pubdate" from titles;

--Print the average, min and max book prices within the titles table organised into groups based on type and publisher id

select type,pub_id , avg(price::numeric), min(price::numeric), max(price::numeric) from titles t 
group by type,pub_id ;

--Refine the previous question to show only those types whose average price is > $20 and output the results sorted on the average price
select type,pub_id , avg(price::numeric), min(price::numeric), max(price::numeric) from titles t 
group by type,pub_id 
having avg(price::numeric) > 20; 

--List the books in order of the length of their title
select title, length(title) from titles t
group by title
order by length(title); 

--What is the average age in months of each type of title
select type, avg((date_part('year', age(current_date,pubdate) * 12) + date_part('month',age(current_date,pubdate)) + (date_part('day',age(current_date,pubdate)) / 30) )) from titles t
group by type;

select type, avg(age(pubdate) * 12) from titles t 
group by type;

--sHow many authors live in each city?
select city, count(au_id) from authors a
group by city ;

--What is the longest title?
select  title from titles t where length(title) = (select max(length(title)) from titles t2);

--How many books have been sold by each store and how many books have been sold in total?
select * from sales s ;
select stor_id, count(qty),sum(qty) from sales s 
group by stor_id ;  --not complete


--************************************************
--            day two, lab two
--************************************************

--Join the publishers and pub_info and show the publisher name and the first 40 characters of the pr_info information.
select p.pub_name ,substring(pi2.pr_info,1,40) from pub_info pi2 inner join publishers p 
on p.pub_id = pi2.pub_id ;

--Join the publishers and titles tables to show all titles published by each publisher. Display the 
--pub_id, pub_name and title_id
select p.pub_id, p.pub_name,t.title_id, t.title from publishers p inner join titles t 
on p.pub_id = t.pub_id ;

--For each title_id in the table titles, rollup the corresponding qty in 
--sales and show: title_id, title, ord_num and the rolled-up value as a column aggregate called Total Sold



--business queries
--How many books have been published by each publisher?
select p.pub_name , count(t.title) as "No. of books written" from publishers p inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name ;

--How many different types of book has each publisher published?
select p.pub_name , count(t.type) as "No. of book types written" from publishers p inner join titles t 
on p.pub_id = t.pub_id 
group by p.pub_name ;

--For each store list which authors have had their books sold through that store
select * from stores s ;












