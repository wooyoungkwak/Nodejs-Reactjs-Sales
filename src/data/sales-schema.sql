-- ***************************************************************
create database sales default character set utf8;


-- ***************************************************************
-- 회원 정보 테이블
CREATE TABLE user(
    userSeq INT PRIMARY KEY AUTO_INCREMENT,
    id VARCHAR(20) NOT NULL,
    pw VARCHAR(20) NOT NULL,
    name VARCHAR(20) NULL,
    phone VARCHAR(13) DEFAULT 'FOO',
    email VARCHAR(100) NOT NULL,
    address VARCHAR(12) NULL
) ENGINE=INNODB;


-- * category 의 종속성에 대한 고려를 하지 않아 다음과 같이 변경 *
-- ================================================================

-- 제품 타입 ( 전자제품 / 식자재 / 의류 / 도서 ...)
CREATE TABLE productType(
    productTypeSeq INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
) ENGINE=INNODB;

-- 상위 분류 테이블
CREATE TABLE mainClass(
    mainClassSeq INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    productTypeSeq INT NOT NULL
) ENGINE=INNODB;

-- 하위 분류 테이블
CREATE TABLE subClass(
    subClassSeq INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    productTypeSeq INT NOT NULL,
    mainClassSeq INT NOT NULL
) ENGINE=INNODB;

-- 제조사 테이블
CREATE TABLE company(
    companySeq INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    productTypeSeq INT NOT NULL,
    mainClassSeq INT NOT NULL,
    subClassSeq INT NOT NULL
) ENGINE=INNODB;

-- ================================================================

-- 제품 테이블
CREATE TABLE product(
    productSeq INT PRIMARY KEY AUTO_INCREMENT,
    thumnail VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    name INT NOT NULL,
    productTypeSeq INT NOT NULL
) ENGINE=INNODB;

-- 구매 목록 테이블
CREATE TABLE purchase(
    purchaseSeq INT PRIMARY KEY AUTO_INCREMENT,
    purchaseDate DATE NOT NULL,
    isDel BIT NOT NULL DEFAULT 0, 
    delDate DATE NULL,
    productSeq INT NOT NULL
) ENGINE=INNODB;


-- ************************************************************

-- 
CREATE PROCEDURE setCategory (
    categoryType INT,
    _name VARCHAR(50),
    _productTypeSeq int,
    _mainClassSeq int,
    _subClassSeq int
)
BEGIN

    DECLARE @SEQ INT;

    CASE categoryType
        WHEN categoryType = 1  THEN
            INSERT INTO productType (name) VALUE (_name);
        WHEN categoryType = 2  THEN
            INSERT INTO mainClass (name, productTypeSeq) VALUE (_name, _productTypeSeq);
        WHEN categoryType = 3  THEN
            INSERT INTO subClass (name, productTypeSeq, mainClassSeq) VALUE (_name, _productTypeSeq, _mainClassSeq);
        WHEN categoryType = 4  THEN
            INSERT INTO company (name, productTypeSeq, mainClassSeq, subClassSeq) VALUE (_name, _productTypeSeq, _mainClassSeq, _subClassSeq);
    END CASE;
END$$
DELIMITER;

-- 
CREATE PROCEDURE setCategoryByParent (
    categoryType INT,
    _myName VARCHAR(50),
    _parentName1 VARCHAR(50),
    _parentName2 VARCHAR(50),
    _parentName3 VARCHAR(50),
)
BEGIN

    DECLARE @PARENT1_SEQ INT;
    DECLARE @PARENT2_SEQ INT;
    DECLARE @PARENT3_SEQ INT;

    CASE 
        WHEN categoryType = 1  THEN
            INSERT INTO productType (name) VALUE (_name);
        WHEN categoryType = 2  THEN
            SET @PARENT1_SEQ = getId(2, _parentName1);
            INSERT INTO mainClass (name, productTypeSeq) VALUE (_name, PARENT1_SEQ);
        WHEN categoryType = 3  THEN
            SET @PARENT1_SEQ = getId(2, _parentName1);
            SET @PARENT2_SEQ = getId(2, _parentName2);
            INSERT INTO subClass (name, productTypeSeq, mainClassSeq) VALUE (_name, PARENT1_SEQ, PARENT2_SEQ);
        WHEN categoryType = 4  THEN
            SET @PARENT1_SEQ = getId(2, _parentName1);
            SET @PARENT2_SEQ = getId(2, _parentName2);
            SET @PARENT3_SEQ = getId(2, _parentName3);
            INSERT INTO company (name, productTypeSeq, mainClassSeq, subClassSeq) VALUE (_name, @PARENT1_SEQ, @PARENT2_SEQ, @PARENT3_SEQ);
    END CASE;
END

CREATE FUNCTION getId(
    categoryType int,
    _name VARCHAR(50)
)
RETURNS INT
BEGIN

    DECLARE @SEQ INT;

    CASE 
        WHEN categoryType = 1  THEN
            SELECT productTypeSeq INTO(@SEQ ) FROM product WHERE name = _name;
        WHEN categoryType = 2  THEN
            SELECT mainClassSeq INTO(@SEQ) FROM mainClass WHERE name = _name;
        WHEN categoryType = 3  THEN
            SELECT subClassSeq INTO(@SEQ) FROM subClass WHERE name = _name;
        WHEN categoryType = 4  THEN
            SELECT companySeq INTO(@SEQ) FROM company WHERE name = _name;
    END CASE;

    RETURN @SEQ;
END 

-- **************************************************************

-- [category data]
-- 전자제품
-- 식자재            
-- 의류
-- 도서

-- - 상위 제품군 : 차량용 / 컴퓨터 
-- - 상위 제품군 : 다이어트 식품 / 간식  
-- - 상위 제품군 : 상의 / 하의
-- - 상위 제품군 : 컴퓨터 / 만화  

-- - 하위 제품군 : 네비게이션, 블랙박스 / 완제품, 조립
-- - 하위 제품군 : 닭가슴살, 샐러드, 곤약밥 / 과자, 견과류, 기타
-- - 하위 제품군 : 반팔, 긴팔, 셔츠, 기타 / 반바지, 긴바지, 치마, 원피스, 기타
-- - 하위 제품군 : 언어, DB, 기타 / 순정, 무협, 판타지, 기타

-- - 제조사 : 하림, cj, 기타 / 롯데, 농심, 해태, 기타
-- - 제조사 : 아디다스, 나이키, 블랙야크 기타
-- - 제조사 : 삼성, LG, 현대, 기타 / 한성, 삼보, 기타
-- - 제조사 : 프리랙, 이지퍼블리싱, 영진닷컴, 기타 / 대원씨아이, 디앤씨웹툰비즈, 학산문화사, 기타

call setCategory(1, '전자제품', 0, 0, 0); 
call setCategory(1, '식자재',   0, 0, 0); 
call setCategory(1, '의류',     0, 0, 0); 
call setCategory(1, '도서',     0, 0, 0); 

call setCategoryByParent(2, '차량용',       '전자제품', '', ''); 
call setCategoryByParent(2, '컴퓨터',       '전자제품', '', ''); 
call setCategoryByParent(2, '다이어트식품', '식자재', '', ''); 
call setCategoryByParent(2, '간식',         '식자재', '', ''); 
call setCategoryByParent(2, '상의',         '의류', '', ''); 
call setCategoryByParent(2, '하의',         '의류', '', ''); 
call setCategoryByParent(2, '컴퓨터',       '도서', '', ''); 
call setCategoryByParent(2, '만화',         '도서', '', ''); 

call setCategoryByParent(2, '네비게이션', '차량용',       '전자제품', ''); 
call setCategoryByParent(2, '블랙박스', '차량용',       '전자제품', ''); 
call setCategoryByParent(2, '완제품', '컴퓨터',       '전자제품', ''); 
call setCategoryByParent(2, '완제품', '컴퓨터',       '전자제품', ''); 
call setCategoryByParent(2, '조립', '다이어트식품', '식자재', ''); 
call setCategoryByParent(2, '닭가슴살', '간식',         '식자재', ''); 
call setCategoryByParent(2, '샐러드', '간식',         '식자재', ''); 
call setCategoryByParent(2, '곤약밥', '간식',         '식자재', ''); 
call setCategoryByParent(2, '과자', '간식',         '식자재', ''); 
call setCategoryByParent(2, '견과류', '간식',         '식자재', ''); 
call setCategoryByParent(2, '기타', '간식',         '식자재', '');
call setCategoryByParent(2, '', '상의',         '의류', ''); 
call setCategoryByParent(2, '', '하의',         '의류', ''); 
call setCategoryByParent(2, '', '컴퓨터',       '도서', ''); 
call setCategoryByParent(2, '', '만화',         '도서', ''); 
