create database mid
use mid


--Question 2

create table Author(
AuthorID INT PRIMARY KEY,
AuthorName varchar(100),
BirthYear int,
DeathYear int
);

create table Book(
BookID int primary key,
AuthorID INT foreign key REFERENCES Author,
BookTitle varchar(100),
PublishYear int,
PublishingHouse varchar(100),
BookRating int
);

create table Adaptations(
AdaptationID INT primary key,
BookID int foreign key references Book,
AdaptationType varchar(100),
AdaptationTitle varchar(100),
ReleaseYear INT,
AdaptationRating INT
);

create table BookReviews(
ReviewID INT primary key,
BookID INT foreign key references Book,
ReviewText varchar(100),
AuthorName varchar(100)
);

--Inserting rows

Insert into Author(AuthorID, AuthorName, BirthYear, DeathYear)
values
(01,'Author first',1900,1990),
(02,'Author second',1901,1991),
(03,'Author third',1902,1992),
(04,'Author fourth',1903,1993),
(05,'Author fifth',1904,1994)
;

insert into Book(BookID,AuthorID,BookTitle,PublishYear,PublishingHouse,BookRating)
values
(01,01,'first book',1931,'House of Books',7.1),
(02,02,'second book',1932,'House of Books',8.1),
(03,03,'third book',1933,'House of Books',9.1),
(04,04,'fourth book',1934,'House of Books',10),
(05,05,'fifth book',1935,'House of Books',2),
(06,05,'sixth book',2007,'House of Books',7);

insert into Adaptations(AdaptationID,BookID,AdaptationType,AdaptationTitle,ReleaseYear,AdaptationRating)
values
(01,01,'movie','first movie',1971,5.1),
(02,02,'movie','second movie',1972,6.1),
(03,03,'movie','third movie',1973,7.1),
(04,04,'movie','fourth movie',1974,8.1),
(05,05,'movie','fifth movie',1975,9.1);

insert into BookReviews(ReviewID,BookID,ReviewText,AuthorName)
values
(01,01,'looking alright','Author first'),
(02,02,'looking good','Author second'),
(03,03,'looking perfect','Author third'),
(04,04,'looking fabulous','Author fourth'),
(05,05,'looking magnificent','Author fifth');

--Query 1

Select Author.AuthorName,Book.BookTitle,Book.PublishYear
FROM Book
JOIN Author on Book.AuthorID=Author.AuthorID
Where PublishYear>2005;


--Query 2
Select Book.BookTitle,Adaptations.AdaptationTitle,Adaptations.ReleaseYear,Book.PublishYear
FROM Book
JOIN Adaptations on Book.BookID=Adaptations.BookID
Where ;


--Query 3
Select Book.BookTitle, Adaptations.AdaptationTitle,Adaptations.ReleaseYear,Book.PublishYear
FROM Book
LEFT JOIN Adaptations on Book.BookID=Adaptations.BookID


--Query 4

Select Book.BookTitle, Adaptations.AdaptationTitle,Adaptations.AdaptationType,Book.PublishingHouse
FROM Book
LEFT JOIN Adaptations on Book.BookID=Adaptations.BookID;
--Query 5

Select Book.BookTitle, BookReviews.ReviewText, BookReviews.AuthorName
FROM BOOK
LEFT JOIN BookReviews on Book.BookID=BookReviews.BookID

--Query 6

Select TOP 5 Author.AuthorName,AVG(Book.BookRating) as book_rating
FROM Author
JOIN Book on Author.AuthorID=Book.AuthorID
group by Author.AuthorName
order by AVG(Book.BookRating) DESC
--Query 7

SELECT TOP 1 BookReviews.AuthorName, count(BookReviews.ReviewID) as review_count
FROM BookReviews
GROUP BY BookReviews.AuthorName