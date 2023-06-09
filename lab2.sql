-- Solution for Lab 2

-- Part 1: Populating the databas

CREATE TABLE book(
    isbn bigint PRIMARY KEY,
    title varchar(255) NOT NULL,
    edition varchar(255),
    language varchar(255),
    publisher varchar(255),
    publication_date date,
    prequel_isbn bigint
);
-- values books without prequels 11x
INSERT INTO book(isbn,title,edition,language,publisher,publication_date)
VALUES
(9781471156267, 'It Ends With Us', 'Paperback Original', 'English', 'Simon & Schuster Ltd', '2016-08-02'),
(9780008537838,'The Fall of Numenor','First','English','HarperCollins Publishers Ltd','2022-11-10'),
(9780349434285,'Twisted Lies','Second','English','Piatkus Books','2022-07-28'),
(9780575089914,'The Final Empire','First','English','Gollancz','2009-10-01'),
(9780571334650,'Normal People','Main','English','Faber & Faber','2019-05-02'),
(9781408891384,'The Song of Achilles','Special Edition','English','Bloomsbury Publishing PLC','2017-09-21'),
(9780141036144,'1984','Fourth','English','Penguin Books Ltd','2008-07-01'),
(9789129722604,'Cirkeln','Third','Swedish','Rabén & Sjögren','2019-06-03'),
(9780135732588,'Calculus','Tenth','English','Pearson Education','2021-05-01'),
(9780393974379,'Java Programming','New','English','WW Norton & Co','2000-08-01'),
(9781292314730,'University Physics with Modern Physics','Global Edition','English','Pearson','2019-10-04'),
(9781408855911,'Harry Potter and the Prisoner of Azkaban','Second','English','Bloomsbury Childrens Books','2014-09-01'),
(9780141393391,'Frankenstein','ED','English','Penguin Classics','2013-10-03')
;
-- values books with prequels 4x
INSERT INTO book(isbn,title,edition,language,publisher,publication_date,prequel_isbn)
VALUES
(9781398518179,'It Starts with Us','Export/Airside','English','Simon & Schuster Ltd','2022-10-18',9781471156267),
(9780575089938,'The Well of Ascension','Third','English','Gollancz','2009-12-10',9780575089914),
(9789129704860,'Eld','First','Swedish','Rabén & Sjögren','2017-02-24',9789129722604),
(9789129704877,'Nyckeln','First','Swedish','Rabén & Sjögren','2017-02-24',9789129704860)
;

CREATE TABLE book_genre(
    isbn bigint REFERENCES book(isbn),
    genre varchar(255),
    PRIMARY KEY (isbn,genre)
);
-- values book genres
INSERT INTO book_genre(isbn,genre)
VALUES
(9781471156267,'Romance'),
(9780008537838,'Fantasy'),
(9780349434285,'Adult Romance'),
(9780575089914,'Fantasy'),
(9780571334650,'Adult Romance'),
(9781408891384,'Fiction'),
(9780141036144,'Science Fiction'),
(9780141036144,'Dystopia'),
(9789129722604,'Fantasy'),
(9789129722604,'Magical Realism'),
(9780135732588,'Calculus'),
(9780393974379,'Programming'),
(9781292314730,'Physics'),
(9781398518179,'Romance'),
(9780575089938,'Fantasy'),
(9789129704860,'Fantasy'),
(9789129704860,'Magical Realism'),
(9789129704877,'Fantasy'),
(9789129704877,'Magical Realism'),
(9781408855911,'Fantasy'),
(9780141393391,'Fantasy'),
(9780141393391,'Horror')
;

CREATE TABLE author(
    author_id int PRIMARY KEY,
    author_name varchar(255) NOT NULL
);
-- values authors
INSERT INTO author(author_id,author_name)
VALUES
(1,'Colleen Hoover'),
(2,'J R R Tolkien'),
(3,'Brian Sibley'),
(4,'Ana Huang'),
(5,'Brandon Sanderson'),
(6,'Sally Rooney'),
(7,'Madeline Miller'),
(8,'George Orwell'),
(9,'Mats Strandberg'),
(10,'Sara Bergmark Elfgren'),
(11,'Robert A Adams'),
(12,'K N King'),
(13,'Hugh D Young'),
(14,'J K Rowling'),
(15,'Mary Shelley')
;

CREATE TABLE book_author(
    isbn bigint REFERENCES book(isbn),
    author_id int REFERENCES author(author_id),
    PRIMARY KEY (isbn,author_id)
);
-- values book writers
INSERT INTO book_author(isbn,author_id)
VALUES
(9781471156267,1),
(9780008537838,2),
(9780008537838,3),
(9780349434285,4),
(9780575089914,5),
(9780571334650,6),
(9781408891384,7),
(9780141036144,8),
(9789129722604,9),
(9789129722604,10),
(9780135732588,11),
(9780393974379,12),
(9781292314730,13),
(9781398518179,1),
(9789129704860,9),
(9789129704860,10),
(9789129704877,9),
(9789129704877,10),
(9781408855911,14),
(9780141393391,15)
;

CREATE TABLE physical_book(
    physical_id int PRIMARY KEY,
    isbn bigint REFERENCES book(isbn),
    damage int
);
-- values physical books 25x
INSERT INTO physical_book(physical_id,isbn,damage)
VALUES
(1,9781398518179,0),
(2,9780008537838,0),
(3,9780349434285,0),
(4,9780575089914,4),
(5,9780575089938,0),
(6,9780571334650,0),
(7,9780571334650,3),
(8,9781408891384,0),
(9,9781408891384,1),
(10,9780141036144,4),
(11,9780141036144,2),
(12,9780141036144,1),
(13,9789129722604,1),
(14,9789129704860,3),
(15,9789129704877,2),
(16,9780135732588,1),
(17,9780135732588,0),
(18,9780393974379,2),
(19,9780393974379,0),
(20,9780393974379,1),
(21,9781292314730,1),
(22,9781292314730,0),
(23,9781292314730,2),
(24,9781292314730,3),
(25,9781292314730,4),
(26,9781408855911,5),
(27,9780141393391,2)
;

CREATE TABLE users(
    user_id int PRIMARY KEY,
    full_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    address varchar(255) NOT NULL
);
-- values users 13x
INSERT INTO users(user_id,full_name,email,address)
VALUES
(1,'Isolde Lundström','ilund@kth.se','Mellangården 89'),
(2,'Zackarias Lund','zlund@kth.se','Edeby 83'),
(3,'Vilgot Wallin','vwall@kth.se','Nytorpsvägen 12'),
(4,'Vanna Nilsson','vnils@kth.se','Ängsgatan 12'),
(5,'Allis Mårtensson','amårten@kth.se','Alsteråvägen 74'),
(6,'Henrietta Strömberg','henstrom@kth.se','Sjötullsgatan 56'),
(7,'Yasin Magnusson','yasmagn@kth.se','Fuglie 23'),
(8,'Kimberly Holmgren','kimholm@kth.se','Stackekärr 87'),
(9,'Lisa Sundberg','lisasund@kth.se','Edebysvägen 5'),
(10,'Josef Lundberg','joseflund@kth.se','Norrfjäll 14'),
(11,'Peter Blomqvist','pblom@kth.se','Södra Kroksdal 78'),
(12,'Svea Bergström','sberg@kth.se','Östbygatan 78'),
(13,'Edward Ekström','edekstrom@kth.se','Mellangården 44')
;

CREATE TABLE student(
    student_id int REFERENCES users(user_id),
    programme varchar(255) NOT NULL
);
-- values students 10x
INSERT INTO student(student_id,programme)
VALUES
(2,'Bioteknik'),
(3,'Datateknik'),
(4,'Elektroteknik'),
(7,'Datateknik'),
(8,'Samhällsbyggnad'),
(9,'Teknisk matematik'),
(10,'Energi och miljö'),
(11,'Industriell ekonomi'),
(12,'Medieteknik'),
(13,'Teknisk fysik')
;

CREATE TABLE admin(
    admin_id int REFERENCES users(user_id),
    department varchar(255) NOT NULL,
    phone_number int NOT NULL UNIQUE
);
-- values admins 3x
INSERT INTO admin(admin_id,department,phone_number)
VALUES
(1,'Computer Science',0769342794),
(5,'Architecture',0768121822),
(6,'Chemical Engineering',0749585486)
;

CREATE TABLE loan(
    borrowing_id int PRIMARY KEY,
    physical_id int REFERENCES physical_book(physical_id),
    user_id int REFERENCES users(user_id),
    borrowing_date date NOT NULL,
    max_time int NOT NULL,
    return_date date
);
-- values loans 10x
INSERT INTO loan(borrowing_id,physical_id,user_id,borrowing_date,max_time,return_date)
VALUES
(1,13,10,'2022-11-10',7,'2022-11-16'), 
(2,2,2,'2022-11-22',7,null), -- late
(3,10,7,'2022-11-25',4,'2022-11-30'), --late
(4,5,3,'2022-11-28',4,'2022-12-01'),
(5,3,3,'2022-11-28',7,null), -- late
(6,13,6,'2022-11-29',7,null),
(7,12,9,'2022-11-29',3,'2022-12-04'), -- late
(8,10,1,'2022-11-30',4,'2022-11-03'),
(9,14,12,'2022-11-30',7,'2022-12-03'),
(10,5,6,'2022-12-01',4,'2022-12-06'), -- late
(11,26,3,'2017-01-15',7,'2017-01-20')
;

CREATE TABLE fine(
    borrowing_id int REFERENCES loan(borrowing_id),
    amount int NOT NULL
);
-- values fines 5x
INSERT INTO fine(borrowing_id,amount)
VALUES
(3,50), -- 50 kr lite sen, 100 mycket sen
(2,100),
(5,50),
(7,50),
(10,50)
;

CREATE TABLE transaction(
    transaction_id int PRIMARY KEY,
    -- transaction_number int, 
    borrowing_id int REFERENCES loan(borrowing_id),
    amount int NOT NULL,
    payment_date date NOT NULL,
    payment_method varchar(255) NOT NULL
);
-- values transactions 
INSERT INTO transaction(transaction_id,borrowing_id,amount,payment_date,payment_method)
VALUES
(1,3,50,'2022-11-30','Cash'),
(2,10,50,'2022-12-06','Mastercard'),
(3,7,25,'2022-12-07','Klarna'),
(4,7,25,'2022-12-08','Klarna')
;

-- Part 2: Querying the database

-- question 1
select full_name from users; 

-- question 2
select book.title, book_genre.genre 
from book_genre
join book on book.isbn = book_genre.isbn 
where genre = 'Fantasy';

-- question 3
select count(borrowing_id) from loan 
where return_date is null;

-- question 4
select book.title, count(physical_book.isbn)
from book
left join physical_book 
on book.isbn = physical_book.isbn
group by book.title, physical_book.isbn;

-- question 5
SELECT round((SELECT COUNT(*) FROM loan)::numeric / (SELECT COUNT(*) FROM users),2)
As average_books_per_user;

-- P+
with prime_sum(p) as (
with recursive t(n) as (
values (2)
union all
select n+1 from t where n < 100
)
select n from t group by n
having n = 2 or n = 3 or n = 5 or n = 7 or mod(n, 2) > 0 
and mod(n, 3) > 0 and mod(n, 5) > 0 and mod(n, 7) > 0
)
select sum(p) from prime_sum;
