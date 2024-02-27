use  madang ;

select * from Orders;

select custid as '고객번호' ,  
	round(sum(saleprice)/count(*), -2) '평균금액'
from Orders
group by custid ;

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
select  LENGTH('대한 민국');

-- 문자열의 문자 수를 반환함
select  CHAR_LENGTH('데이터');
select  CHAR_LENGTH('APPLE');

SELECT * FROM bOOK;

select * from Book;

SELECT	bookid, REPLACE(bookname, '야구', '농구') bookname, 
		publisher, 	price
        FROM	Book;

[4-5]
SELECT 	bookname '제목', CHAR_LENGTH(bookname) '문자수',	
		LENGTH(bookname) '바이트수'
FROM 	Book
WHERE 	publisher='굿스포츠';

select * from  Customer;

SELECT	SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
FROM	Customer
GROUP BY	SUBSTR(name, 1, 1);

SELECT * FROM Orders;

SELECT	orderid '주문번호', orderdate '주문일', 
ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM	Orders;


[4-8]
select * from Orders;

SELECT	orderid '주문번호', 
	DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일', 
custid '고객번호', bookid '도서번호'
FROM	Orders
WHERE	orderdate= STR_TO_DATE('20240707', '%Y%m%d');

SELECT SYSDATE(),
DATE_FORMAT(SYSDATE(), '%Y/%m/%d %a %h:%i') 'SYSDATE_시스템날짜시간';

select * from Customer ;

SELECT	name '이름', IFNULL(phone, '연락처없음') '전화번호' 
FROM	Customer;

-- Mybook 스키마 생성 -- MySQL
CREATE TABLE Mybook (
  bookid      INTEGER,
  price       INTEGER 
);

-- Mybook 데이터 생성
INSERT INTO Mybook VALUES(1, 10000);
INSERT INTO Mybook VALUES(2, 20000);
INSERT INTO Mybook VALUES(3, NULL);

COMMIT;

select * from Mybook;

select sum(price), avg(price), count(*), count(price)
from Mybook;

select * from Mybook;

select sum(price), avg(price), count(*)
from Mybook
where  bookid >=4 ;

select * from Mybook
wherE price IS NULL ;

#아래는 실행 안됨
select * from Mybook
where price = '' ;

select * from Customer;

select name '이름' , IFNULL(phone, '연락처없음') '전화번호'
from Customer ;

set @seq:=0 ;

select (@seq := @seq + 1) '연번', custid, name, phone
from Customer
where @seq < 2 ;

select orderid , saleprice
from orders
where saleprice <= ( select  avg(saleprice ) from  orders);

select * from  orders;

select orderid , custid, saleprice
from Orders  od1
where saleprice  > ( select  avg(saleprice) 
					from Orders od2
                    where od1.custid = od2.custid ) ;
                    
                    
select * from Customer ;     
select * from orders ;      

select  Sum(saleprice) 'total' 
from  Orders
where custid IN( SELECt custid from Customer
					where address LIKE '%대한민국%') ;           

SELECT	orderid, saleprice
FROM	Orders
WHERE	saleprice > ALL ( SELECT saleprice
FROM	Orders
WHERE	custid='3' );


SELECT  SUM(saleprice) 'total'
from Orders  od
where  EXISTS ( SELECT * FROM Customer  cs
						where address LIKE '%대한민국%' AND 
                        cs.custid = od.custid ) ;

select (   select  name from Customer cs
			where cs.custid = od.custid) '이름' ,
            sum(saleprice)  'total'            
from  Orders  od
group by od.custid ;

alter  table  Orders  add bname varchar(40) ;
select * from Orders;

select * from Book;

use madang;

update Orders
set bname = ( select bookname from  Book
				where Book.bookid = Orders.bookid) ;
select * from Orders;

select cs.name , sum(saleprice)  'total'
from ( select custid ,name from Customer
			where custid <= 2) cs , Orders  od
where cs.custid = od.custid 
group by  cs.custid ;





