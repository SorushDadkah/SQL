USE Library
GO

--Library Drill Questions

--1. How many copies of the book titled The Lost Tribe are owned by the library branch whose name
--is"Sharpstown"?

SELECT b.BookId, b.No_Of_Copies, l.BranchId, l.BranchName
FROM Book_Copies AS b
JOIN Library_Branch AS l
ON b.BranchId = l.BranchId
WHERE b.BookId = 1 AND l.BranchId = 4;

--2. How many copies of the book titled The Lost Tribe are owned by each library branch?

SELECT b.Title, bc.BookId, bc.No_Of_Copies, l.BranchId, l.BranchName
FROM Book AS b
JOIN Book_Copies as bc
ON b.BookId = bc.BookId
JOIN Library_Branch as l
ON bc.BranchId = l.BranchId
WHERE b.Title = 'The Lost Tribe';

--3. Retrieve the names of all borrowers who do not have any books checked out.

SELECT b.FirstName, b.LastName, bl.DueDate
FROM Borrower AS b
LEFT OUTER JOIN Book_Loans AS bl
ON b.CardNo = bl.CardNo
WHERE bl.DueDate IS NULL;


--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
-- retrieve the book title, the borrower's name, and the borrower's address.

SELECT l.BranchName, bl.DueDate, b.Title, bw.FirstName, bw.LastName, bw.Street, bw.[State]
FROM Library_Branch AS l
JOIN Book_Loans AS bl 
ON l.BranchId=bl.BranchId	
JOIN Book AS b
ON bl.BookId = b.BookId
JOIN Borrower AS bw
ON bl.CardNo = bw.CardNo
WHERE l.BranchName = 'Sharpstown Library' AND bl.DueDate = '2017-03-25';

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from
-- that branch.

SELECT COUNT(l.BranchName) AS BooksOut, l.BranchName
FROM Book_Loans AS bl
JOIN Library_Branch AS l
ON bl.BranchId = l.BranchId
GROUP BY l.BranchName;

--6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more
--than five books checked out.

SELECT COUNT(bw.CardNo) AS CardNo, bw.FirstName, bw.LastName, bw.Street, bw.[State]
FROM Borrower AS bw
JOIN Book_Loans as bl
ON bw.CardNo = bl.CardNo
GROUP BY bw.FirstName, bw.LastName, bw.Street, bw.[State]
HAVING COUNT(bw.CardNo) >= 5;


--7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of
-- copies owned by the library branch whose name is "Central".

SELECT b.Title, bc.No_Of_Copies, l.BranchName
FROM Book_Authors AS a
JOIN Book AS b
ON a.BookId = b.BookId
JOIN Book_Copies AS bc
ON b.BookId = bc.BookId
JOIN Library_Branch AS l
ON bc.BranchId = l.BranchId
WHERE FirstName = 'Stephen' And LastName = 'King' AND BranchName = 'Central Library';

-- Stored Procedure of #7

USE Library
GO

CREATE PROC spGetAuthorsName(
@FirstName nvarchar(50),
@LastName nvarchar(50))
AS

	SELECT b.Title, bc.No_Of_Copies, l.BranchName
	FROM Book_Authors AS a
	JOIN Book AS b
	ON a.BookId = b.BookId
	JOIN Book_Copies AS bc
	ON b.BookId = bc.BookId
	JOIN Library_Branch AS l
	ON bc.BranchId = l.BranchId
	WHERE FirstName = @FirstName AND LastName = @LastName  
	ORDER BY LastName;
 
spGetAuthorsName @FirstName = 'Stephen', @LastName = 'King';