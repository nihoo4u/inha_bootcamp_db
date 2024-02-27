import  pymysql
def get_by_price():
    #데이터베이스  접속 관련 변수들 초기화
    host = "localhost"
    port = 3306
    database = "madang"
    username = "root"
    password = "jj45805237"
    #접속 상태 확인
    conflag = True

    try:
        print("데이터베이스 연결 준비...")
        conn = pymysql.connect(host=host, user=username ,password=password,
                            db=database,port=port, charset='utf8')
        print("데이터베이스 연결 성공")
    except Exception  as  err:
        print("데이터베이스 연결 실패:")
        conflag = False

    #접속에 성공한다면 쿼리문 실행
    if conflag == True:
        #커서(cursor) 객체 생성
        cursor = conn.cursor()
        sqlString = '''create or replace view highorders(bookid,bookname,name,publisher,saleprice)
                       as select o.bookid,b.bookname,c.name,b.publisher,o.saleprice
                       from customer c,book b,orders o 
                       where o.bookid=b.bookid and o.custid=c.custid;
                       '''
        cursor.execute(sqlString)      
        sqltring2=     '''
                       select bookid,bookname,name,publisher,saleprice
                       from highorders
                       where saleprice = 20000;
                       '''

            
        
        cursor.execute(sqltring2)
        data = cursor.fetchall()
        print("data의 타입=" , type(data)) 

        print('{0}\t{1:<} \t{2:<} \t {3:<} \t{4:>}'.format(
                "bookid", "bookname","customername","publisher", "price") )
        #레코드들 출력
        for rowdata  in  data:
            if rowdata[4] == None:
                print('{0}\t{1:<} \t{2:<} \t{3:<} \t{4:<}'.format(
                rowdata[0], rowdata[1], rowdata[2], rowdata[3],0 ) )
            else:
                print('{0}\t{1:<} \t{2:<} \t{3:>} \t{4:<}'.format(
                    rowdata[0], rowdata[1], rowdata[2], rowdata[3],rowdata[4] ) )
        
        cursor.close()
        conn.close()
def get_names():
    #데이터베이스  접속 관련 변수들 초기화
    host = "localhost"
    port = 3306
    database = "madang"
    username = "root"
    password = "jj45805237"
    #접속 상태 확인
    conflag = True

    try:
        print("데이터베이스 연결 준비...")
        conn = pymysql.connect(host=host, user=username ,password=password,
                            db=database,port=port, charset='utf8')
        print("데이터베이스 연결 성공")
    except Exception  as  err:
        print("데이터베이스 연결 실패:")
        conflag = False

    #접속에 성공한다면 쿼리문 실행
    if conflag == True:
        #커서(cursor) 객체 생성
        cursor = conn.cursor()
        
            
        sqltring2=     '''
                       select ifnull(bookname,0),ifnull(name,0)
                       from highorders;
                       
                       '''

            
        
        cursor.execute(sqltring2)
        # data = cursor.fetchall()
        # print("data의 타입=" , type(data)) 
        

        temp_data=cursor.fetchall()
        # print(f"도서:{temp_data[0]}, 고객이름:{temp_data[1]}")
        for i in temp_data:
            print(f"도서이름: {i[0]}, 책 이름: {i[1]}")
        cursor.close()
        conn.close()
def delete_price():
        #데이터베이스  접속 관련 변수들 초기화
    host = "localhost"
    port = 3306
    database = "madang"
    username = "root"
    password = "jj45805237"
    #접속 상태 확인
    conflag = True

    try:
        print("데이터베이스 연결 준비...")
        conn = pymysql.connect(host=host, user=username ,password=password,
                            db=database,port=port, charset='utf8')
        print("데이터베이스 연결 성공")
    except Exception  as  err:
        print("데이터베이스 연결 실패:")
        conflag = False

    #접속에 성공한다면 쿼리문 실행
    if conflag == True:
        #커서(cursor) 객체 생성
        cursor = conn.cursor()
        
            
        sqltring2=     '''
                       create or replace view highorders(bookid,bookname,name,publisher)
                       as select o.bookid, b.bookname,c.name,b.publisher
                          from customer c, orders o, book b 
                          where o.bookid=b.bookid and c.custid=o.custid;
                          
                       
            '''
        

        cursor.execute(sqltring2)
        cursor.fetchall()
        

        sqltring=     '''
                       select ifnull(bookname,0),ifnull(name,0)
                       from highorders;
                       
                       '''
        cursor.execute(sqltring)

        
        

        temp_data=cursor.fetchall()
        
        for i in temp_data:
            print(f"도서이름: {i[0]}, 책 이름: {i[1]} ")
        cursor.close()
        conn.close()


if __name__ == "__main__":
    # getprice=int(input("input the price"))
    # get_by_price()
    get_names()
    # delete_price()
    