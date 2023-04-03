-- Lab3

-- question 1

select books.title, string_agg(genre.genre, ', ')genre 
from genre
left join books on books.bookid = genre.bookid
group by books.title
order by title;

-- question 2

select * from (
select books.title,
rank() over(order by count(borrowing.dob) desc)rank
from genre
left join books on books.bookid = genre.bookid
left join resources on resources.bookID = books.bookID
left join borrowing on borrowing.physicalid = resources.physicalid
where genre.genre = 'RomCom'
group by books.title) as t
where t.rank < 6;

-- question 3

select f.week, f.borrowed, l.returned, l.late
from
-- correct output for the two first columns
(select date_part('week', dob)week, count(date_part('week', dob))borrowed
from borrowing
where date_part('week', dob) < 31
group by week
order by week) as f
left join
-- correct output for the two last columns
(select
date_part('week', dor)weekr,
count(dor)returned,
count(dor) filter (where dor > doe)late
from borrowing
group by weekr
order by weekr) as l
on f.week=l.weekr;

-- question 4

select books.title,
case
    when prequelid is not null then true
    when prequelid is null then false
end prequel,
borrowing.dob as date
from books
left join prequels on books.bookid = prequels.bookid
left join resources on resources.bookID = books.bookID
left join borrowing on borrowing.physicalid = resources.physicalid
Where date_part('month', dob) = 2 and dob is not null
order by title;

-- question 5

with recursive series as (
-- base case: last book in series
select title, books.bookid, prequelid
from books
join prequels on prequels.bookid = books.bookid
where books.bookid = 8713
-- adds the recursive part
UNION
-- recursion: where the rest of the books are added
select books.title, books.bookid, prequels.prequelid
from series, books
left join prequels on prequels.bookid = books.bookid 
or prequels.bookid is null
where series.prequelid = books.bookid
)
select * from series;

-- p+ 

with recursive series as (
-- base case: last book in series
select title, books.bookid, prequelid, pages
from books
join prequels on prequels.bookid = books.bookid
where books.bookid = 30553
-- adds the recursive part
UNION
-- recursion: where the rest of the books are added
select books.title, books.bookid, prequels.prequelid, books.pages
from series, books
left join prequels on prequels.bookid = books.bookid 
or prequels.bookid is null
where series.prequelid = books.bookid
)
select string_agg(series.title, ' -> ')series, sum(series.pages) from series;
