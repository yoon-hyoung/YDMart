# YDMart 

## Goal

Make my shopping mall **web page**!!

Working with **database** (jsp and mysql)

## To Start

***Setting***

Ubuntu 18.04.1 LTS

mysql  Ver 14.14 Distrib 5.7.24, for Linux (x86_64) using  EditLine wrapper

OpenJDK Runtime Environment (build 10.0.2+13-Ubuntu-1ubuntu0.18.04.4)

OpenJDK 64-Bit Server VM (build 10.0.2+13-Ubuntu-1ubuntu0.18.04.4, mixed mode)

tomcat v8.5

```git clone https://github.com/yoon-hyoung/YDMart.git```

Starting with ```http://localhost:8080/test/login_input.jsp```

** 주의 사항 : 화면비율을 잘못 조정할 경우 홈페이지 화면이 원본과  나타날 수 있으므로 창을 너무 크게 하지 마세요 (모니터에 따라 전체화면 불가)**

** 각 페이지 상단의 홈페이지 로고 클릭시 메인으로 링크됨**

## Content
***Login***
![2018-12-03 22-47-48](https://user-images.githubusercontent.com/30612084/49377427-80c90400-f74d-11e8-9858-dc354a8cd57b.png)

***Logout***

![2018-12-03 22-11-16](https://user-images.githubusercontent.com/30612084/49377482-a48c4a00-f74d-11e8-9d28-7c65d4503446.png)

### Customer Mode
***Sign Up***
![2018-12-03 21-41-39](https://user-images.githubusercontent.com/30612084/49376839-ecaa6d00-f74b-11e8-8700-ef8281266fb9.png)

***Category***
![2018-12-03 21-46-51](https://user-images.githubusercontent.com/30612084/49376917-1b284800-f74c-11e8-9a7a-ccde68609965.png)

***Cart***
![2018-12-03 21-58-13](https://user-images.githubusercontent.com/30612084/49376963-32ffcc00-f74c-11e8-880b-65980f90a723.png)

***Order***
![2018-12-03 21-58-35](https://user-images.githubusercontent.com/30612084/49376977-385d1680-f74c-11e8-9dd9-0019098ada08.png)

***Search Item***
![2018-12-03 21-47-32](https://user-images.githubusercontent.com/30612084/49376925-1fecfc00-f74c-11e8-9c83-6aa664354b0c.png)

***See Ordered List***
![2018-12-03 22-49-52](https://user-images.githubusercontent.com/30612084/49377531-c5549f80-f74d-11e8-800e-11e16bd194fa.png)

### Manager Mode
***Stock Manage***

Manage your shopping mall stock.

![2018-12-03 22-24-59](https://user-images.githubusercontent.com/30612084/49377775-62173d00-f74e-11e8-934e-1d8edaeaca01.png)


***See Revenue***

You can see the revenue by total,month,date.

![2018-12-03 22-25-06](https://user-images.githubusercontent.com/30612084/49377789-693e4b00-f74e-11e8-8abc-4a839992e33a.png)

![2018-12-03 22-25-17](https://user-images.githubusercontent.com/30612084/49377794-6b080e80-f74e-11e8-805d-25adf4c45410.png)


## index for search

### 1.ITEM TABLE

    CREATE INDEX ix_ITEM ON ITEM (NAME);
 
: jsp코드를 생성하면서 parameter로 item name 을 전달하는 경우가 빈번히 일어났다. 
이렇게 받은 NAME 파라미터로 PK인 I_NUM을 검색하기도 하였고 이 값을 토대로 가격 등의 정보를 조회하기도 하였다.
따라서 빈번히 검색이 일어나는 필드인 NAME 필드를 대상으로 인덱스를 생성하게 되었다.

### 2.CUSTOMER TABLE

    CREATE INDEX ix_CUSTOMER ON CUSTOMER (ID);
 
: 초기 테이블을 생성하였을 때 고객의 관리를 편하게 하기 위해서 C_ID라는 INT형 필드를 생성하였다. 
하지만 jsp코드를 실제로 작성하는 과정에서는 ID를 인자로 받아 session값으로 지정하게 되었다. 
이로인해 다른 테이블을 참조하기 위해서 추가적인 검색이 필요하게 되었고 이를 위해 ID를 대상으로 한 인덱스를 생성하게 되었다.

### 3.ORDERED TABLE

    CREATE INDEX ix_ORDERED ON ORDERED (CUS_NUM);
 
: ORDERED 테이블의 기본키는 O_NUM이다. 이는 ORDERED의 관리를 편하게 해주고 이를 마트에서 활용하는 정보로 쓸 경우, 유용하다.
하지만 ORDERED는 고객과 아이템 사이에 존재하는 일종의 관계라고 볼 수도 있다. (우리는 테이블로 구현하였으나 경우에 따라 관계 테이블로 만들 수 있다고 생각한다.)
그렇게 때문에 CUSTOMER 테이블과의 참조가 빈번히 일어나게 되었고 이를 위해 CUSTOMER NUMBER를 대상으로 한 인덱스를 구성하게 되었다.

## shopping mall function
  별(*)  처리된 것은 추가과제를 구현 한 것임.

### 1. member function
  1) 회원가입
  
    +필수정보 (이름, 아이디, 비밀번호, 주소(도시, 우편주소), 전화번호) 를 입력하지 않은 경우 가입 불가
    +아이디 중복시 가입 불가
    
  2) 신규고객 상품 추천 (*)
  
    +신규 고객이 추가 정보 (나이, 성별) 입력시 이를 기준으로 상품을 추천해줌
    +추가 정보 입력하지 않았거나 추가 정보 관련 주문 데이터가 없는 경우 전체 주문 기준으로 아이템을 추천해줌
    
  3) 로그인
  
    +아이디, 비밀번호 입력하지 않은 경우 에러 출력
    +아이디, 비밀번호 일치하지 않는 경우 에러 출력
    
  4) 회원 정보 수정
  
    +default 값으로 자신이 기존에 입력한 값이 입력되어있음
    +아이디 변경 불가
    
  5) 비밀 번호 수정
  
    +비밀번호 변경시 새로운 비밀번호를 2번 입력해야하므로 안정성이 높음
    
  6) 관리자 계정 로그인
  
    +관리자 계정 로그인시 관리자 페이지로 연결
    +관리자 계정 ID : SYD    PW : SYD
    
### 2. item function

  1) 아이템 목록 전체 열람 가능
  
    +로그인 이후 아이템 열람 가능
    +전체 아이템을 열람할 수 있음 (main 페이지)
    
  2) 서브카테고리별 아이템 목록 열람 가능
  
    +서브카테고리 선택을 통해 카테고리별 아이템 열람 가능
    
  3) 현재 열람 중인 아이템 목록들 중 특정 아이템 검색 가능 (메인 페이지에서 전체 아이템 대상 검색 가능)
  
    + 현재 페이지에서 열람 중인 아이템들 중 검색 가능 
    + 메인 페이지에서 전체 아이템 대상 검색 가능
    
  4) 물품 선택 시 세부정보 페이지로 이동
  
    + 물품 열람 중 특정 물품 선택시 세부정보 페이지로 이동
    + 생산자 정보를 포함한 아이템 정보 열람 가능
    
  5) 수량 선택 후 장바구니에 추가 가능
    
    +물품 세부정보 페이지에서 고객의 장바구니로 상품 추가 가능
    +물품의 수량 선택 가능
    
  6) 구매하고자 하는 아이템의 수량이 부족한 경우 구매 불가
  
    +장바구니 페이지에서 상품 구입을 위한 선택이 불가
    +주문 창으로 진행 할 수 없도록 처리하였음
  
### 3. shopping cart function

  1) 고객별 카트 회원가입시 생성
    
    +회원 가입시 고객 카트 생성
    +카트 정보는 디비에 저장되므로 로그아웃 하여도 정보는 그대로 남아있음
    +재로그인시 이전에 담았던 카트 상품 남아있음 
   
  2) 카트에서 아이템 선택시 아이템 상세 페이지로 이동
  
    +카트에서 아이템 리스트의 특정 아이템 선택시 상세페이지로 이동
    +수량 추가가 가능함
    
  3) 카트에서 아이템 삭제 가능
    
    +카트수정 페이지로 이동 후 아이템 삭제 가능     
     
  4) 카트에서 구입할 아이템 선택후 구입 가능
  
    +자신이 원하는 아이템 카트에서 선택후 구입 가능
    +재고 부족한 상품은 주문 불가
    
### 4. purchase function

  1) 장바구니에서 구입 가능
  
  2) 자신의 주문 내역 확인 가능 - 주문 내역 선택시 주문 세부 정보 확인 가능
    
    +아이템 구입시 주문내역에 추가됨을 확인할 수 있음
    
  3) 구입하고자하는 물품이 가장 가까운 마트에 없을 경우 차선 마트에서 배송해줌
  
    +전체 검색을 통해 차선 마트에서 배송
    +물품별 배송 출발지가 다를 수 있음
    +물품에 대한 매장별 재고에 따라 하나의 물품도 여러 배송 출발지에서 배송이 시작될 수 있음
  
  4) 트랜잭션 구현을 통해 동시에 여러 고객이 구입을 할 수 있다 (*)
  
    +트랜잭션을 통해 동시성 구현
    +작업 수행중 에러 발생시 주문 과정 전체 취소됨
  
  5) 아이템 구입시 장바구니에서 삭제 
  
    +구입한 아이템들은 자동으로 장바구니에서 삭제됨
   
### 5. manager function

  1) 관리자 ID, PW 로 로그인시 진행 가능 (ID : SYD, PW : SYD )
    
    +패스워드 일치하지 않을 경우 이용 불가
      
  2) 물품의 재고를 주문할 수 있다.
    
    +매장별 물품의 재고를 주문할 수 있음
    
  3) 매니저는 모든 물품의 열람 및 주문이 가능하며 물품은 재고가 부족한 순으로 정렬하여 보여준다.
  
    +부족한 물픔의 주문을 보다 편리하게 하기 위해 물품은 재고가 부족한 순으로 보여줌
  
  4) 매출선택을 통해 전체, 월별, 일별 매출을 각각 볼 수 있다.
