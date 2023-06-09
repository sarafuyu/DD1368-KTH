-- Solution for Lab 1
 
CREATE TABLE Books(
    physical_id int PRIMARY KEY,
    Title varchar(255) NOT NULL,
    Author varchar(255),
    Edition int,
    Genre varchar(255),
    Language varchar(255),
    Publisher varchar(255),
    date_publication date,
    Prequel varchar(255),
    Damage boolean
);
-- Inserting values to the table Books
Insert into Books(physical_id,Title,Author,Edition,Genre,Language,Publisher,date_publication,Prequel,Damage)
Values(1,'Pippi på de sju haven','Astrid Lindgren',2,'Barnbok','Svenska','Albert Bonniers Förlag','1994-02-12','Pippi på äventyr',FALSE);
Insert into Books(physical_id,Title,Author,Edition,Genre,Language,Publisher,date_publication,Damage)
Values(2,'Ronja Rövardotter','Astrid Lindgren',6,'Barnbok','Svenska','Albert Bonniers Förlag','1996-02-12',TRUE);

CREATE TABLE Users(
    user_id int PRIMARY KEY,
    full_name varchar(255) NOT NULL,
    Email varchar(255) NOT NULL,
    Address varchar(255) NOT NULL
);
-- Inserting values to the table Users
Insert into Users(user_id,full_name,Email,Address)
Values(1,'Al Andersson','ala@kth.se','Åvägen 6'),(2,'Bob Löv','boblov@kth.se','Kristinas väg 3');

CREATE TABLE Students (
    student_id int REFERENCES Users(user_id),
    Programme varchar(255) NOT NULL
);
-- Inserting values to the table Students
Insert into Students(student_id,Programme)
Values(1,'Datateknik');

CREATE TABLE Admins(
    admin_id int REFERENCES Users(user_id),
    Department varchar(255) NOT NULL,
    phone_number int NOT NULL
);
-- Inserting values to the table Admins
Insert into Admins(admin_id, Department, phone_number)
Values(2,'Computer Science', 0853682631);

CREATE TABLE Loans(
    borrowing_id int PRIMARY KEY,
    physical_id int REFERENCES Books(physical_id),
    user_id int REFERENCES Users(user_id),
    date_borrowing date NOT NULL,
    due_date date NOT NULL,
    date_return date
);
-- Inserting values to the table Loans
Insert into Loans(borrowing_id,physical_id,user_id,date_borrowing,due_date,date_return)
Values(1,1,1,'2022-10-10','2022-10-13','2022-10-21');

CREATE TABLE Fines(
    borrowing_id int REFERENCES Loans(borrowing_id),
    Amount int NOT NULL
);
-- Inserting values to the table Fines
Insert into Fines(borrowing_id,Amount)
Values(1,306);

CREATE TABLE Transactions(
    transaction_id int PRIMARY KEY,
    borrowing_id int REFERENCES Loans(borrowing_id),
    Amount int NOT NULL,
    date_payment date NOT NULL,
    payment_method varchar(255) NOT NULL
);
-- Inserting values to the table Transactions
Insert into Transactions(transaction_id,borrowing_id,Amount,date_payment,payment_method)
Values(1,1,306,'2022-11-02','Swish');
