use  madang;
select * from  book;

select * from  book
where publisher in ('굿스포츠', '대한미디어');

select * from  book
where publisher = '굿스포츠' or 
	publisher ='대한미디어' ;


select * from  book
where publisher not in ('굿스포츠', '대한미디어');

select bookname , publisher
from  book
where  bookname like '축구의 역사' ;

select bookname , publisher
from  book
where  bookname like '%축구%' ;

select bookname , publisher
from  book
where  bookname like '_구%' ;

select *
from  book
where bookname like '%축구%' and price >= 20000 ;

select * from book
order by  bookname;

select * from book
order by  bookname asc;

select * from book
order by  bookname desc;

select * from book
order by  price , bookname ;

select * from book
order by  price desc , publisher asc ;

select sum(price) from  book ;
select avg(price) from  book ;

CREATE TABLE Customer(
	custid  integer primary key,
    name varchar(40),
    address varchar(50),
    phone varchar(20)
);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스터', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

select * from  Customer ;

create table Orders(
	orderid  integer primary key ,
    custid  integer references Customer(custid),
    bookid integer references Book(bookid) ,
    saleprice integer ,
    orderdate  date );
    

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2024-07-01','%Y-%m-%d'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2024-07-04','%Y-%m-%d'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2024-07-05','%Y-%m-%d'));

INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2024-07-08','%Y-%m-%d'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2024-07-09','%Y-%m-%d'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2024-07-10','%Y-%m-%d'));

SELECT * FROM Orders;

select sum(saleprice) 
from Orders ;

select sum(saleprice) AS  총매출
from Orders ;

select sum(saleprice) as 총매출
from Orders
where custid = 2 ;

select sum(saleprice)  as Total,
		avg(saleprice) as Average,
        min(saleprice) as  Minimun,
        max(saleprice) as Maximum
from  Orders;

select count(*)
from Orders;

select custid , count(*) as 도서수량, sum(saleprice) as 총액
from  Orders
group by custid ;
	
select custid , count(*) as 도서수량, sum(saleprice) as 총액
from  Orders
group by custid 
order by custid desc;
   
   
select custid , count(*) as 도서수량, sum(saleprice) as 총액
from  Orders
group by custid 
order by sum(saleprice) desc;

select custid , count(*) as 도서수량
from  Orders
group by custid ;

select custid , count(*) as 도서수량
from  Orders
where saleprice >=8000
group by custid 
having count(*) >= 2;

select *
FROM  Customer , Orders;

select *
FROM  Customer , Orders
where Customer.custid = Orders.custid;

select *
FROM  Customer , Orders
where Customer.custid = Orders.custid
order by Customer.custid ;

select name, saleprice
FROM  Customer , Orders
where Customer.custid = Orders.custid ;

select name, SUM(saleprice)
FROM  Customer , Orders
where Customer.custid = Orders.custid 
GROUP BY Customer.name 
order by Customer.name ;

select Customer.name, Book.bookname
FROM  Customer , Orders , Book
where Customer.custid = Orders.custid and 
		Orders.bookid = Book.bookid ;
        
select Customer.name, Book.bookname
FROM  Customer , Orders , Book
where Customer.custid = Orders.custid and 
		Orders.bookid = Book.bookid and Book.price = 20000 ;
        
select Customer.name, saleprice
FROM  Customer left outer join Orders on 
		Customer.custid = Orders.custid ;        
       

select * FROM   Orders;
select *  from  Customer;

select bookname  from  book
where price  = (select  MAX(price) from  book) ;
	
select name  from  Customer
where custid  in ( select custid from Orders ) ;

select bookid from  book
where publisher ='대한미디어' ;

select  custid  from  Orders
where bookid  in (3,4) ;

select  custid  from  Orders
where bookid  in (select bookid from  book
where publisher ='대한미디어' ) ;

select name from Customer
	where custid in ( 
		select  custid  from  Orders
			where bookid  in (
				select bookid from  book
				where publisher ='대한미디어' ) ) ;

select b1.bookname
from Book  b1 
where b1.price > ( select avg(price)  from  Book  b2
				where b2.publisher = b1.publisher) ;

select name from Customer
where address LIKE '대한민국%' ;

SELECT name from Customer
where custid  in ( select custid from Orders );

select name from Customer
where address LIKE '대한민국%' 
UNION
SELECT name from Customer
where custid  in ( select custid from Orders );

select name from Customer
where address LIKE '대한민국%' 
UNION ALL
SELECT name from Customer
where custid  in ( select custid from Orders );

SELECT name from Customer
where address LIKE '대한민국%' AND
	name NOT IN(
		select name from Customer
			where custid IN( select custid from Orders ) );

SELECT name from Customer
where address LIKE '대한민국%' AND
		name IN( select name from Customer
			where custid IN( select custid from Orders ) );

select name , address from Customer  AS cs
where EXISTS ( SELECT * from  Orders  AS  od
				where cs.custid = od.custid ) ;
                
select name , address from Customer  cs
where EXISTS ( SELECT * from  Orders  od
				where cs.custid = od.custid ) ;


CREATE TABLE 	NewBook (
  bookname		VARCHAR(20)	NOT NULL,
  publisher		VARCHAR(20)	UNIQUE,
  price		INTEGER DEFAULT 10000 CHECK(price > 1000),
  PRIMARY KEY	(bookname, publisher));
  
drop table NewBook;

 CREATE TABLE	NewBook (
  bookid		INTEGER,
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price		INTEGER,
  PRIMARY KEY	(bookid));

drop table NewBook;

CREATE TABLE	NewBook (
  bookid		INTEGER	PRIMARY KEY,
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price		INTEGER);
  
drop table newbook;

CREATE TABLE 	NewBook (
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price 		INTEGER,
  PRIMARY KEY	(bookname, publisher));
  
drop table newbook;

CREATE TABLE	NewCustomer (
  custid		INTEGER	PRIMARY KEY,
  name			VARCHAR(40),
  address		VARCHAR(40),
  phone			VARCHAR(30));

CREATE TABLE	NewOrders (
  orderid	INTEGER,
  custid	INTEGER	NOT NULL,
  bookid	INTEGER	NOT NULL,
  saleprice	INTEGER,
  orderdate	DATE,
  primary key(orderid) ,
  foreign key(custid) references NewCustomer(custid)
  on delete cascade, 
  foreign key(bookid) references NewBook(bookid)
  on delete cascade) ;

select * from NewBook;

alter table NewBook add isbn varchar(13);
alter table NewBook modify isbn integer ;

#######기본키 변경 True
drop table NewOrders;
drop table NewBook;

 CREATE TABLE	NewBook (
  bookname		VARCHAR(20) PRIMARY KEY,
  bookid		INTEGER	,  
  publisher		VARCHAR(20),
  price		INTEGER);
  

ALTER TABLE NewBook DROP PRIMARY KEY;
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

select * from NewBook;
drop table newbook;

[3-42]
DROP TABLE NewBook;

[3-43]
DROP TABLE NewCustomer;
SELECT * FROM	NewCustomer;

DROP TABLE NewOrders;
DROP TABLE NewCustomer;

SELECT * FROM	newbook;
SELECT * FROM	NewCustomer;
SELECT * FROM	neworders;


[3-44]
INSERT INTO Book(bookid, bookname, publisher, price)
		VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
#DELETE FROM Book where bookid = 12;

SELECT * FROM	book;

INSERT INTO Book
		VALUES (12, '스포츠 의학', '한솔의학서적', 90000);

INSERT INTO Book(bookid, bookname, price, publisher)
		VALUES (13, '스포츠 의학', 90000, '한솔의학서적');

SELECT * FROM	book;

[3-45]
INSERT INTO Book(bookid, bookname, publisher)
		VALUES (14, '스포츠 의학', '한솔의학서적');
       
SELECT * FROM	book;

-- 여기는 3장에서 사용되는 Imported_book 테이블
CREATE TABLE Imported_Book (
  bookid		INTEGER,
  bookname	VARCHAR(40),
  publisher	VARCHAR(40),
  price		INTEGER
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

SELECT * FROM	Imported_Book;

COMMIT;

[3-46]
INSERT INTO Book(bookid, bookname, price, publisher)
	   SELECT	bookid, bookname, price, publisher
	   FROM 	Imported_book;
       
SELECT * FROM	book;


[3-47]
SET SQL_SAFE_UPDATES=0;

UPDATE	Customer
SET		address ='대한민국 부산'
WHERE	custid=5;

select * from Customer;

[3-48]
SELECT * FROM	book;
UPDATE	book 
SET	publisher = (SELECT	publisher 
				FROM	imported_book 
				WHERE	bookid = '21') 
WHERE	bookid = '14';


[3-49]
DELETE FROM Book 
WHERE  bookid = '11'; 

SELECT * FROM	book;


[3-50]
DELETE	FROM	Customer;  
SELECT * FROM	Customer;

#######Chap 4
[4-1]
SELECT 	ABS(-78), ABS(+78);


[4-2]
SELECT	ROUND(4.875, 1);


[4-3]
SELECT	custid '고객번호', ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액'
FROM	Orders
GROUP BY	custid;


-- 두 문자열을 연결함
select CONCAT('마당', ' 서점');

-- 대상 문자열을 모두 소문자로 변환함
select LOWER('MR. SCOTT');

-- 대상 문자열의 왼쪽부터 지정한 자릿수까지 지정한 문자로 채움
select  LPAD('Page 1', 10, '*');

-- 대상 문자열의 지정한 문자를 원하는 문자로 변경함
select  REPLACE('JACK & JUE', 'J', 'BL');

-- 대상 문자열의 오른쪽부터 지정한 자릿수까지 지정한 문자로 채움
select  RPAD('AbC', 5, '*');

-- 대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환함
select  SUBSTR('ABCDEFG', 3, 4);

-- 대상 문자열의 양쪽에서 지정된 문자를 삭제함(문자열만 넣으면 기본값으로 공백 제거)
select  TRIM('=' FROM '==BROWNING==');

-- 대상 문자열을 모두 대문자로 변환함
select  UPPER('mr. scott');

-- 대상 알파벳 문자의 아스키코드 값을 반환함
select  ASCII('D') ;

-- 대상 문자열의 byte를 반환함(알파벳은 1byte, 한글은 3byte(UTF-8))
select  LENGTH('CANDIDE');
select  LENGTH('대한민국');

-- 문자열의 문자 수를 반환함
select  CHAR_LENGTH('데이터');
select  CHAR_LENGTH('APPLE');


[4-4]
select * from Book;

SELECT	bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, 
		price
FROM	Book;

[4-5]
SELECT 	bookname '제목', CHAR_LENGTH(bookname) '문자수',	
		LENGTH(bookname) '바이트수'
FROM 	Book
WHERE 	publisher='굿스포츠';


[4-6]
select * from  Customer;

SELECT	SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
FROM	Customer
GROUP BY	SUBSTR(name, 1, 1);


[4-7]
select * from Orders;

SELECT	orderid '주문번호', orderdate '주문일', 
ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM	Orders;


[4-8]
SELECT	orderid '주문번호', DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일', 
custid '고객번호', bookid '도서번호'
FROM	Orders
WHERE	orderdate= STR_TO_DATE('20240707', '%Y%m%d');


[4-9]
SELECT SYSDATE(),
DATE_FORMAT(SYSDATE(), '%Y/%m/%d %a %h:%i') 'SYSDATE_1';


[4-10]
SELECT	name '이름', IFNULL(phone, '연락처없음') '전화번호' 
FROM	Customer;


[4-11]
SET 	@seq:=0;

SELECT	(@seq:=@seq+1) '순번', custid, name, phone
FROM	Customer
WHERE 	@seq < 2;


[4-12]
SELECT orderid, saleprice
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice)
FROM Orders);


[4-13]
SELECT	orderid, custid, saleprice
FROM	Orders od1
WHERE	saleprice> (SELECT AVG(saleprice)
FROM	Orders od2
WHERE	od1.custid=od2.custid);


[4-14]
SELECT	SUM(saleprice) 'total'
FROM	Orders
WHERE	custid IN (SELECT custid
FROM	Customer
WHERE	address LIKE '%대한민국%');


[4-15]
SELECT	orderid, saleprice
FROM	Orders
WHERE	saleprice > ALL (SELECT saleprice
FROM	Orders
WHERE	custid='3');


[4-16]
SELECT	SUM(saleprice) 'total'
FROM	Orders od
WHERE	EXISTS (SELECT *
		FROM	Customer cs
		WHERE	address LIKE '%대한민국%' AND cs.custid=od.custid);


[4-17]
SELECT	(SELECT	name
		FROM	Customer cs
		WHERE	cs.custid=od.custid) 'name', SUM(saleprice) 'total'
FROM	Orders od
GROUP BY	od.custid;


[4-18]
ALTER TABLE Orders ADD bname VARCHAR(40);
UPDATE	Orders
SET	bname=(SELECT bookname
			FROM Book
			WHERE Book.bookid=Orders.bookid);


[4-19]
SELECT	cs.name, SUM(od.saleprice) 'total'
FROM	(SELECT custid, name
		FROM Customer
		WHERE custid <= 2) cs, Orders od
WHERE	cs.custid=od.custid
GROUP BY	cs.name;


[4-20]
CREATE VIEW	vw_Customer
AS SELECT		*
	FROM		Customer
	WHERE		address LIKE '%대한민국%';
    
    
SELECT	*
FROM	vw_Customer;


[4-21]
CREATE VIEW	vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT	od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
	FROM	Orders od, Customer cs, Book bk
	WHERE	od.custid=cs.custid AND od.bookid=bk.bookid;
    

SELECT	orderid, bookname, saleprice
FROM	vw_Orders
WHERE	name ='김연아';


[4-22]
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS  SELECT		custid, name, address
	FROM		Customer
	WHERE		address LIKE '%영국%';

SELECT	*
FROM	vw_Customer;


[4-23]
DROP VIEW	vw_Customer;

SELECT	*
FROM	vw_Customer;


[4-24]
CREATE INDEX ix_Book ON Book(bookname);


[4-25]
CREATE INDEX ix_Book2 ON Book(publisher, price);

show index from book;


[4-26]
ANALYZE TABLE Book;


[4-27]
DROP INDEX ix_Book ON Book;
















select bookname from Book where  bookname LIKE '%축구%' ;
select bookname from Book where  bookname LIKE '%[축구]%' ;
select bookname from Book where  bookname LIKE '[3]%' ;

select bookname from Book where  bookname LIKE '\[3-4\]%' ;

select bookname from Book where  bookname REGEXP '%[O]%' ;

