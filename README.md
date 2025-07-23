# 📚 Library Management System – SQL Project

This is a mini Library Management System built using **MySQL Workbench**, designed to demonstrate fundamental SQL concepts like table creation, relationships, data manipulation,
and reporting using SQL queries.
---
## 🛠️ Tools Used
- MySQL Workbench
- SQL (DDL & DML)
- ER Model concepts
---
## 📂 Database Schema
The system contains the following tables:
- **Books** – Stores information about books.
- **Members** – Holds data about library members.
- **Librarians** – Contains librarian staff info.
- **Borrowing** – Tracks borrowed books, due dates, and returns.
### 🔗 Relationships
- Each borrowing record links to:
  - A `book_id` from `Books`
  - A `member_id` from `Members`
  - A `librarian_id` from `Librarians`
---
## 📥 Sample SQL Features
### ✅ DDL (Table Creation)

```sql
CREATE TABLE Books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100),
  genre VARCHAR(50),
  published_year INT
);
