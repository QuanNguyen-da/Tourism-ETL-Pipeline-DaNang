
DROP TABLE Customer;
select * from flickr_new

CREATE TABLE Customer (--tạo các cột trùng với cột đầu ra ở ssis
    UserID NVARCHAR(500) not null,---Chuỗi chứa nhiều loại kí tự và dài nên để Nvarchar cho chắc. 
--đổi kiểu dữ liệu bên đầu ra ssis là DT_WSTR để khớp với kiểu dữ liệu chứa dấu. 
--input column nhớ để readwriten
--sửa phần script-- nhớ check lỗi script ở erro list trước khi chạy 
    Country NVARCHAR(500),
    UserID1 NVARCHAR(500),
    Country1 NVARCHAR(500)
);
--đổi tên thành customer
select * from customer
---dữ liệu cào để mô phỏng cách xây kho nên số lượng còn ít, load mất nhiều thời gian quá
--xóa cột country
ALTER TABLE customer
DROP COLUMN country1;


ALTER TABLE customer
DROP COLUMN UserID1;

DELETE FROM dbo.Customer
WHERE UserID1 IS NULL;
--xem giá trị trùng lặp
SELECT UserID1, COUNT(*) AS Count
FROM dbo.Customer
GROUP BY UserID1
HAVING COUNT(*) > 1;
--thêm cột để mã hóa
ALTER TABLE Customer
ADD EncodedUserID NVARCHAR(50);
--mã hóa lại cột UserID. 
;WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY (SELECT NULL)) AS RowNum
    FROM dbo.Customer
)
DELETE FROM CTE WHERE RowNum > 1;
WITH NumberedUsers AS (
    SELECT 
        UserID,
        ROW_NUMBER() OVER (ORDER BY UserID) AS RowNum
    FROM 
        Customer
)
UPDATE Customer
SET EncodedUserID = 'KDL_' + CAST(RowNum AS NVARCHAR(10))
FROM NumberedUsers
WHERE Customer.UserID = NumberedUsers.UserID;

select * from customer
--đổi tên cột -- thực hiện bên Object Explorer
-- set khóa
ALTER TABLE Customer
ADD CONSTRAINT UserID PRIMARY KEY (UserID);
--kiểm tra giá trị null
SELECT *
FROM Customer
WHERE UserID IS NULL;

--kiểm tra trùng lặp
SELECT UserID, COUNT(*)
FROM Customer
GROUP BY UserID
HAVING COUNT(*) > 1;
--chuyển đổi thuộc tính thành not null
ALTER TABLE Customer
ALTER COLUMN UserID NVARCHAR(50) NOT NULL;
--set lại khóa
ALTER TABLE Customer
ADD CONSTRAINT UserID PRIMARY KEY (UserID);
select * from customer






ALTER TABLE flickr_new
DROP COLUMN UserID, Country;

DELETE FROM flickr_new
WHERE UserID1 IS NULL;
select * from flickr_new

CREATE TABLE Location (
   -- Khóa chính với cột tự tăng
    Ward NVARCHAR(255),                        -- Cột Ward kiểu NVARCHAR
    District NVARCHAR(255)                     -- Cột District kiểu NVARCHAR
);
select * from Location
TRUNCATE TABLE Location;

-- Xóa bảng Location nếu nó đã tồn tại
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Location;
END

-- Tạo lại bảng Location với 4 cột
CREATE TABLE dbo.Location
(
    Ward NVARCHAR(500),
    District NVARCHAR(500),
    LocationID NVARCHAR(500),
    District1 NVARCHAR(500)
);
ALTER TABLE location
DROP COLUMN   District;

DELETE FROM location
WHERE LocationID IS NULL;
select * from location
SELECT *
FROM dbo.Location
WHERE LocationID LIKE 'X%' OR Ward = N'Phường Hải Châu II';

SELECT *
FROM dbo.Location
WHERE Ward = N'Xã Điện Ngọc' 

DELETE FROM dbo.Location
WHERE Ward = N'Xã Điện Ngọc' 


UPDATE dbo.Location
SET 
    Ward = N'Phường Hòa Ninh',
    LocationID = 'PHN'
WHERE 
    Ward = N'Xã Hoà Ninh' AND 
    LocationID = 'XHN';
SELECT *
FROM dbo.Location
WHERE LocationID LIKE 'X%' OR Ward = N'Phường Hải Châu II';
UPDATE dbo.Location
SET LocationID = 'PHC_II'
WHERE Ward = N'Phường Hải Châu II';
UPDATE dbo.Location
SET District1 = N'Hải Châu District'
WHERE Ward = N'Phường Hải Châu II' AND District1 IS NULL;
select * from location

ALTER TABLE location
DROP COLUMN  District;

DELETE FROM location
WHERE LocationID IS NULL;
select * from location
--đặt khóa cho bảng Location
ALTER TABLE dbo.Location
ADD CONSTRAINT PK_Location PRIMARY KEY (LocationID);
ALTER TABLE dbo.Location
ALTER COLUMN LocationID NVARCHAR(500) NOT NULL;
--lỗi giới hạn độ dài
ALTER TABLE dbo.Location
ALTER COLUMN LocationID NVARCHAR(255) NOT NULL;

--lỗi trùng lặp
SELECT LocationID, COUNT(*)
FROM dbo.Location
GROUP BY LocationID
HAVING COUNT(*) > 1;
;WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY LocationID ORDER BY (SELECT NULL)) AS RowNum
    FROM dbo.Location
)
DELETE FROM CTE WHERE RowNum > 1;
ALTER TABLE dbo.Location
--thực hiện lại đặt khóa chính
ADD CONSTRAINT PK_Location PRIMARY KEY (LocationID);

select * from Flickrr
select * from flickr


CREATE TABLE Photo 
(
    PhotoID NVARCHAR(50) not null,
--sửa phần script-- nhớ check lỗi script ở erro list trước khi chạy 
    UserID1 NVARCHAR(100),
	PhotoTitle NVARCHAR(300),
    DateTaken NVARCHAR(100),
	PhotoURL nvarchar(500),
	Description nvarchar(255),
	Ward nvarchar(255)

)

select * from Photo
ALTER TABLE Photo
ADD UserID NVARCHAR(255),  -- Thêm cột UserID
    LocaID NVARCHAR(255);  -- Thêm cột LocaID

UPDATE P
SET P.UserID = C.UserID  -- Cập nhật cột UserID của bảng Photo
FROM Photo P
JOIN Customer C ON P.UserID1 = C.UserID1; 
select * from customer -- Dựa vào UserID1 trong cả hai bảng để cập nhật

select * from Photo
UPDATE P
SET P.LocaID = L.LocationID  -- Cập nhật cột UserID của bảng Photo
FROM Photo P
JOIN Location L ON P.Ward = L.Ward; 
select * from photo
select * from Location

select ward, locaID from Photo where LocaID is null
UPDATE P
SET P.LocaID = L.LocationID  -- Cập nhật cột LocaID trong bảng Photo
FROM Photo P
JOIN Location L ON P.Ward = L.Ward  -- Kết nối hai bảng dựa trên cột Ward
WHERE P.Ward = L.Ward;  -- Điều kiện đảm bảo Ward giống nhau

select * from Photo where locaid is null
UPDATE Photo
SET LocaID = 
    (LEFT(Ward, 1) + 
    SUBSTRING(Ward, CHARINDEX(' ', Ward) + 1, 1) + 
    SUBSTRING(Ward, LEN(Ward) - CHARINDEX(' ', REVERSE(Ward)) + 2, 1))
WHERE LocaID IS NULL;  -- Chỉ cập nhật các hàng có giá trị LocaID là NULL
select * from photo
ALTER TABLE Photo
ADD CONSTRAINT PK_Photo PRIMARY KEY (PhotoID);
select * from photo
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UserID' AND COLUMN_NAME = 'LocationID';

--muốn liên kết thì PK và FK của 2 bảng phải cùng data Type
ALTER TABLE Photo
ALTER COLUMN UserID NVARCHAR(50) NOT NULL;

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Customer' AND COLUMN_NAME = 'UserID';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Photo' AND COLUMN_NAME = 'UserID';


CREATE TABLE Hotel 
(
    HotelID NVARCHAR(50) not null,
--sửa phần script-- nhớ check lỗi script ở erro list trước khi chạy 
    HotelURL NVARCHAR(100),
	Score NVARCHAR(300),
    TotalReview NVARCHAR(100),
	Ward nvarchar(500),
	Service nvarchar(255),
	Location nvarchar(255),
	Facilities nvarchar(255),
	Cleaness nvarchar(255),
	ValueOfMoney nvarchar(255)
)

CREATE TABLE Hotel (
    HotelID nvarchar(50) not null,
    HotelURL NVARCHAR(255),
    Score NVARCHAR(255),
    TotalReviews NVARCHAR(255),
    Ward NVARCHAR(255),
    Service NVARCHAR(100),
    Location NVARCHAR(100),
    Facilities NVARCHAR(100),
    Cleanliness NVARCHAR(100),
    ValueForMoney NVARCHAR(100)
);

select * from Hotel
ALTER TABLE Hotel
ALTER COLUMN Totalreview VARCHAR(600);  -- hoặc dùng TEXT cho dữ liệu dài hơn
DROP TABLE   Hotel 

ALTER TABLE DQ
ALTER COLUMN HotelURL nvarchar(500);
ALTER TABLE DQ
ALTER COLUMN score nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN totalreviews nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN service nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN location nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN facilities nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN cleanliness nvarchar(255);
ALTER TABLE DQ
ALTER COLUMN valuemoney nvarchar(255);

ALTER TABLE NT
ALTER COLUMN HotelURL nvarchar(max);
ALTER TABLE NT
ALTER COLUMN score nvarchar(255);
ALTER TABLE NT
ALTER COLUMN totalreviews nvarchar(255);
ALTER TABLE NT
ALTER COLUMN service nvarchar(255);
ALTER TABLE NT
ALTER COLUMN location nvarchar(255);
ALTER TABLE NT
ALTER COLUMN facilities nvarchar(255);
ALTER TABLE NT
ALTER COLUMN cleanliness nvarchar(255);
ALTER TABLE NT
ALTER COLUMN valuemoney nvarchar(255);

CREATE TABLE Hotel1 (
    Score FLOAT,
    total_reviews NVARCHAR(255),
    ward NVARCHAR(255),
    Cleanliness FLOAT,
    Facilities FLOAT,
    location FLOAT,
    value_for_money FLOAT,
    service FLOAT,
    hotelID INT not null
);
select * from Hotel

UPDATE P
SET P.UserID = C.UserID  -- Cập nhật cột UserID của bảng Photo
FROM Photo P
JOIN Customer C ON P.UserID1 = C.UserID1; 
select * from customer 
UPDATE  H
SET H .Ward1 = L.LocationID  -- Cập nhật cột UserID của bảng Photo
FROM hotel H 
JOIN Location L ON H.ward = L.Ward; 
select * from location 
select * from Hotel where ward1 is null

select * from hotel

--đặt khóa cho bảng Location
ALTER TABLE dbo.hotel
ADD CONSTRAINT PK_hotel PRIMARY KEY (hotelid);
ALTER TABLE dbo.Location
ALTER COLUMN LocationID NVARCHAR(500) NOT NULL;
--lỗi giới hạn độ dài
ALTER TABLE dbo.hotel
ALTER COLUMN hotelid int NOT NULL;

--lỗi trùng lặp
SELECT hotelid, COUNT(*)
FROM dbo.hotel
GROUP BY hotelid
HAVING COUNT(*) > 1;

