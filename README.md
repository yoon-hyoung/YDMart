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
1.CUSTUMER TABLE
CREATE INDEX ix_ITEM ON ITEM (NAME);
: jsp코드를 생성하면서 parameter로 item name 을 전달하는 경우가 빈번히 일어났다. 
이렇게 받은 NAME 파라미터로 PK인 I_NUM을 검색하기도 하였고 이 값을 토대로 가격 등의 정보를 조회하기도 하였다.
따라서 빈번히 검색이 일어나는 필드인 NAME 필드를 대상으로 인덱스를 생성하게 되었다.

2.CUSTOMER TABLE
CREATE INDEX ix_CUSTOMER ON CUSTOMER (ID);
: 초기 테이블을 생성하였을 때 고객의 관리를 편하게 하기 위해서 C_ID라는 INT형 필드를 생성하였다. 
하지만 jsp코드를 실제로 작성하는 과정에서는 ID를 인자로 받아 session값으로 지정하게 되었다. 
이로인해 다른 테이블을 참조하기 위해서 추가적인 검색이 필요하게 되었고 이를 위해 ID를 대상으로 한 인덱스를 생성하게 되었다.

3.ORDERED TABLE
CREATE INDEX ix_ORDERED ON ORDERED (CUS_NUM);
: ORDERED 테이블의 기본키는 O_NUM이다. 이는 ORDERED의 관리를 편하게 해주고 이를 마트에서 활용하는 정보로 쓸 경우, 유용하다.
하지만 ORDERED는 고객과 아이템 사이에 존재하는 일종의 관계라고 볼 수도 있다. (우리는 테이블로 구현하였으나 경우에 따라 관계 테이블로 만들 수 있다고 생각한다.)
그렇게 때문에 CUSTOMER 테이블과의 참조가 빈번히 일어나게 되었고 이를 위해 CUSTOMER NUMBER를 대상으로 한 인덱스를 구성하게 되었다.

## shopping mall function

1. member function

2. item function

3. shopping cart function

4. purchase function

5. manager function

