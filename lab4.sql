-- PART 1

-- FOREIGN KEY constraints

ALTER TABLE Admins ADD CONSTRAINT FK_Admins_Users FOREIGN KEY (userID) REFERENCES Users(userID);

ALTER TABLE Author ADD CONSTRAINT FK_Author_Books FOREIGN KEY (bookID) REFERENCES Books(bookID);

ALTER TABLE Books ADD CONSTRAINT FK_Books_Edition FOREIGN KEY (bookID) REFERENCES Books(bookID);

ALTER TABLE Borrowing ADD CONSTRAINT FK_Borrowing_Resources FOREIGN KEY (physicalID) REFERENCES Resources(physicalID);
ALTER TABLE Borrowing ADD CONSTRAINT FK_Borrowing_Users FOREIGN KEY (userID) REFERENCES Users(userID);

ALTER TABLE Edition ADD CONSTRAINT FK_Edition_Books FOREIGN KEY (bookID) REFERENCES Books(bookID); 

ALTER TABLE Fines ADD CONSTRAINT FK_Fines_Borrowing FOREIGN KEY (borrowingID) REFERENCES Borrowing(borrowingID);

ALTER TABLE Genre ADD CONSTRAINT FK_Genre_Books FOREIGN KEY (bookID) REFERENCES Books(bookID);

ALTER TABLE Language ADD CONSTRAINT FK_Language_Books FOREIGN KEY (bookID) REFERENCES Books(bookID);

ALTER TABLE Prequels ADD CONSTRAINT FK_Book_Prequels_Books FOREIGN KEY (bookID) REFERENCES Books(bookID); -- different naming convention
ALTER TABLE Prequels ADD CONSTRAINT FK_Prequel_Prequels_Books FOREIGN KEY (prequelID) REFERENCES Books(bookID); -- different naming convention

ALTER TABLE Resources ADD CONSTRAINT FK_Resources_Books FOREIGN KEY (bookID) REFERENCES Books(bookID);

ALTER TABLE Students ADD CONSTRAINT FK_Students_Users FOREIGN KEY (userID) REFERENCES Users(userID);

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Borrowing FOREIGN KEY (borrowingID) REFERENCES Borrowing(borrowingID);

-- Add SET NOT NULL constraints

ALTER TABLE Books ALTER COLUMN title SET NOT NULL;
ALTER TABLE Books ALTER COLUMN pages SET NOT NULL;

ALTER TABLE Edition ALTER COLUMN ISBN SET NOT NULL;

ALTER TABLE Author ALTER COLUMN author SET NOT NULL;

ALTER TABLE Genre ALTER COLUMN genre SET NOT NULL;

ALTER TABLE Language ALTER COLUMN language SET NOT NULL;

ALTER TABLE Users ALTER COLUMN name SET NOT NULL;
ALTER TABLE Users ALTER COLUMN address SET NOT NULL;
ALTER TABLE Users ALTER COLUMN email SET NOT NULL;

ALTER TABLE Students ALTER COLUMN program SET NOT NULL;

ALTER TABLE Admins ALTER COLUMN department SET NOT NULL;
ALTER TABLE Admins ALTER COLUMN phoneNumber SET NOT NULL;

ALTER TABLE Fines ALTER COLUMN amount SET NOT NULL;

ALTER TABLE Transactions ALTER COLUMN paymentMethod SET NOT NULL;
ALTER TABLE Transactions ALTER COLUMN DoP SET NOT NULL;

-- Add check constraints

ALTER TABLE Fines
ADD CONSTRAINT CK_Fines_amount
CHECK (
	amount > 0
);

ALTER TABLE Books
ADD CONSTRAINT CK_Books_pages
CHECK (
	pages > 0
);

ALTER TABLE Edition
ADD CONSTRAINT CK_Edition_edition_positive
CHECK (
	edition > 0
);

ALTER TABLE Borrowing
ADD CONSTRAINT CK_Borrowing_dor_dob
CHECK (
	dor >= dob
);

ALTER TABLE users
ADD CONSTRAINT CK_Users_email
CHECK (
	email LIKE '%@kth.se'
);

-- PART 2

-- countries and borders

with cte as(
	select name, count 
	from(
		select border_count.name, count(border_count.name)
		from(
			select country.name
			from country
			join borders on borders.country1 = country.code
			or borders.country2 = country.code
		)
		as border_count
		group by border_count.name
	) as t1)
select cte.name, cte.count from cte
where cte.count = (select min(cte.count) from cte);

-- most spoken language

select people.language, 
round(sum(people.population * people.percentage * 0.01)) as numberspeaker
from(
	select country.population, spoken.percentage, spoken.language
	from country
	join spoken on spoken.country = country.code
	where spoken.percentage IS NOT NULL
) as people
group by people.Language
order by numberspeaker desc;

-- gdp ratio between bordering countries

select * 
from(
	select c1.country1, c1.gdp1, c1.country2, gdp as gdp2, round(c1.gdp1/gdp) as ratio
	from(
		select borders.country1, economy.gdp as gdp1, borders.country2
		from Borders 
		join Economy on borders.country1 = economy.country 
	) as C1
	join economy on c1.country2 = economy.country

	union all

	select c1.country1, c1.gdp1, c1.country2, gdp as gdp2, round(gdp/c1.gdp1) as ratio
	from(
		select borders.country1, economy.gdp as gdp1, borders.country2
		from Borders 
		join Economy on borders.country1 = economy.country 
	) as C1
	join economy on c1.country2 = economy.country
	
) as C2
where ratio is not null
order by ratio desc;
