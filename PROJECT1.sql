CREATE DATABASE LibraryDB;
USE LibraryDB;
-- Create the Books table :
-- book_id: unique identifier for each book, auto-incremented, primary key
-- title: the title of the book, cannot be null
-- author: the author of the book, cannot be null
-- genre: optional genre of the book
-- published_year: year the book was published
-- is_available: status if the book is available, defaults to TRUE (available)
CREATE TABLE Books 
(
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    author VARCHAR(300) NOT NULL,
    genre VARCHAR(100),
    published_year YEAR,
    is_available BOOLEAN DEFAULT TRUE
);
commit;
-- Create the Members table :
-- member_id: unique identifier for each member, auto-incremented, primary key
-- name: member's full name, cannot be null
-- email: optional email address
-- phone_number: optional contact number
-- join_date: the date the member joined, defaults to the current date
CREATE TABLE Members (
    member_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(300) NOT NULL,
    email VARCHAR(300),
    phone_number VARCHAR(15),
    join_date DATE DEFAULT (CURRENT_DATE)
);
commit;
-- Create the Librarians table:
-- librarian_id: unique identifier for each librarian, auto-incremented, primary key
-- name: librarian's full name, cannot be null
-- email: optional email address
-- phone_number: optional contact number
-- hire_date: the date the librarian was hired, defaults to the current date
CREATE TABLE Librarians (
    librarian_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(300) NOT NULL,
    email VARCHAR(300),
    phone_number VARCHAR(15),
    hire_date DATE DEFAULT (CURRENT_DATE)
);
commit;
-- Create the Borrowing table to manage borrowing transactions:
-- loan_id: unique identifier for each loan, auto-incremented, primary key
-- book_id: foreign key referencing the Books table
-- member_id: foreign key referencing the Members table
-- borrow_date: the date the book was borrowed, defaults to current date
-- return_date: the date the book was returned (can be NULL if not returned yet)
-- librarian_id: foreign key referencing the Librarians table
CREATE TABLE Borrowing (
    loan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    librarian_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES Librarians(librarian_id)
);
SELECT * FROM Books WHERE book_id = 1;

-- Inserting Data:
-- Books Table:
-- Insert book records into the Books table:
-- Insert book records into the Books table
INSERT INTO Books (title, author, genre, published_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orwell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);

-- Members Table:
-- Insert member records into the Members table
INSERT INTO Members (name, email, phone_number) VALUES
('Alen King', 'alenking@example.com', '1234567890'),
('Alece Hofman', 'alecehofman@example.com', '9876543210');
 select * from  members;
-- Librarians Table:
-- Insert librarian records into the Librarians table
INSERT INTO Librarians (name, email, phone_number) VALUES 
('Nail Horn', 'nail@example.com', '4567891230'), 
('Garden McGraw', 'garden@example.com', '7894561230');
select * from librarians;
-- WRITING QUERIES FOR FUNCTIONALITY:
-- Borrow Book
INSERT INTO Borrowing (book_id, member_id, librarian_id, borrow_date)
VALUES (7, 1, 1, CURRENT_DATE);
-- QUERY1:
UPDATE Books
SET is_available = FALSE
WHERE book_id = 7;

-- 	QUERY2:Return a Book (Update Return Date and Book Availability)
UPDATE Borrowing
SET return_date = current_date
where loan_id = 1;

select * from borrowing;
select * from books;
UPDATE Books
SET is_available = TRUE
WHERE book_id = 7;
-- Check Available Books
SELECT * FROM Books
WHERE is_available = TRUE;
-- QUERY4- View Member Loan History
SELECT m.name, b.title, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE m.member_id = 1;

-- QUERY5-List Overdue Books (Books Not Returned in 14 Days)
SELECT m.name, b.title, br.borrow_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.borrow_date < CURRENT_DATE - INTERVAL 14 DAY;
-- Output not generated for insufficient data

-- QUERY 6-List All Books by a Specific Author
-- List All Books by a Specific Author
SELECT title, genre, published_year
FROM Books
WHERE author = 'George Orwell';
-- Query-7: Find Books Published After a Certain Year
SELECT title, author, published_year
FROM Books
WHERE published_year > 2000;
-- Output not available for insufficient data
-- Query-8: Count Total Books in the Library
SELECT COUNT(*) AS total_books
FROM Books;

--  QUERY-9: View All Members Who Borrowed a Specific Book
SELECT m.name, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE b.title = '1984';
-- Query-10: Find Borrowing History of a Specific Member
SELECT b.title, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Books b ON br.book_id = b.book_id
WHERE br.member_id = 1;
-- Query-11: Calculate the Total Number of Books Borrowed by Each Member
SELECT m.name, COUNT(br.loan_id) AS total_books_borrowed
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
GROUP BY m.name;






