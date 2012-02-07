
-- Run as nanotrader user
DROP TABLE IF EXISTS HOLDING cascade;
DROP TABLE IF EXISTS ACCOUNTPROFILE cascade;
DROP TABLE IF EXISTS QUOTE cascade;
DROP TABLE IF EXISTS KEYGEN cascade;
DROP TABLE IF EXISTS ACCOUNT cascade;
DROP TABLE IF EXISTS "order" cascade;

DROP SEQUENCE IF EXISTS account_sequence;
DROP SEQUENCE IF EXISTS accountprofile_sequence;
DROP SEQUENCE IF EXISTS holding_sequence;
DROP SEQUENCE IF EXISTS order_sequence;
DROP SEQUENCE IF EXISTS quote_sequence;


CREATE TABLE HOLDING (
	PURCHASEPRICE NUMERIC(14, 2) NULL,
   	HOLDINGID INTEGER NOT NULL,
   	QUANTITY NUMERIC NOT NULL,
   	PURCHASEDATE DATE NULL,
   	ACCOUNT_ACCOUNTID INTEGER NULL,
   	QUOTE_SYMBOL varchar(250) NULL );

ALTER TABLE HOLDING
  ADD CONSTRAINT PK_HOLDING PRIMARY KEY (HOLDINGID);

CREATE TABLE ACCOUNTPROFILE
  (PROFILEID INTEGER NOT NULL,
   ADDRESS varchar(250) NULL,
   PASSWD varchar(250) NULL,
   USERID varchar(250) NOT NULL,
   EMAIL varchar(250) NULL,
   CREDITCARD varchar(250) NULL,
   FULLNAME varchar(250) NULL);

ALTER TABLE ACCOUNTPROFILE
  ADD CONSTRAINT PK_ACCOUNTPROFILE PRIMARY KEY (PROFILEID);

ALTER TABLE ACCOUNTPROFILE
  ADD CONSTRAINT UNIQ_ACCOUNTPROFILE UNIQUE (USERID);

  CREATE TABLE QUOTE
  (QUOTEID INTEGER NOT NULL,
   LOW DECIMAL(14, 2) NULL,
   OPEN1 DECIMAL(14, 2) NULL,
   VOLUME NUMERIC NOT NULL,
   PRICE DECIMAL(14, 2) NULL,
   HIGH DECIMAL(14, 2) NULL,
   COMPANYNAME varchar(250) NULL,
   SYMBOL varchar(250) NOT NULL,
   CHANGE1 NUMERIC NOT NULL);

ALTER TABLE QUOTE
  ADD CONSTRAINT PK_QUOTE PRIMARY KEY (QUOTEID);

ALTER TABLE QUOTE
  ADD CONSTRAINT UNIQ_QUOTE UNIQUE (SYMBOL);

--CREATE TABLE KEYGEN
--  (KEYVAL INTEGER NOT NULL,
--   KEYNAME varchar(250) NOT NULL);

--ALTER TABLE KEYGEN
--  ADD CONSTRAINT PK_KEYGEN PRIMARY KEY (KEYNAME);

CREATE TABLE ACCOUNT
  (CREATIONDATE DATE NULL,
   OPENBALANCE DECIMAL(14, 2) NULL,
   LOGOUTCOUNT INTEGER NOT NULL,
   BALANCE DECIMAL(14, 2) NULL,
   ACCOUNTID INTEGER NOT NULL,
   LASTLOGIN DATE NULL,
   LOGINCOUNT INTEGER NOT NULL,
   PROFILE_PROFILEID Integer NULL);

ALTER TABLE ACCOUNT
  ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (ACCOUNTID);

ALTER TABLE
  ACCOUNT ADD CONSTRAINT FK_ACCT_PROF FOREIGN KEY (PROFILE_PROFILEID) REFERENCES ACCOUNTPROFILE (PROFILEID);

CREATE TABLE "order"
  (ORDERFEE DECIMAL(14, 2) NULL,
   COMPLETIONDATE DATE NULL,
   ORDERTYPE varchar(250) NULL,
   ORDERSTATUS varchar(250) NULL,
   PRICE DECIMAL(14, 2) NULL,
   QUANTITY NUMERIC NOT NULL,
   OPENDATE DATE NULL,
   ORDERID INTEGER NOT NULL,
   ACCOUNT_ACCOUNTID INTEGER NULL,
   QUOTE_SYMBOL varchar(250) NULL,
   HOLDING_HOLDINGID INTEGER NULL);


ALTER TABLE "order"
  ADD CONSTRAINT PK_ORDER PRIMARY KEY (ORDERID);

ALTER TABLE "order"
  ADD CONSTRAINT FK_ORD_ACCT FOREIGN KEY (ACCOUNT_ACCOUNTID) REFERENCES ACCOUNT (ACCOUNTID);

ALTER TABLE "order"
  ADD CONSTRAINT FK_ORD_HOLD FOREIGN KEY (HOLDING_HOLDINGID) REFERENCES HOLDING (HOLDINGID);  
  
CREATE INDEX ACCOUNT_PROFILEID  ON ACCOUNT(PROFILE_PROFILEID);
CREATE INDEX HOLDING_ACCOUNTID ON HOLDING (ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_ACCOUNTID ON "order" (ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_HOLDINGID ON "order" (HOLDING_HOLDINGID);
CREATE INDEX CLOSED_ORDERS   ON "order" (ACCOUNT_ACCOUNTID,ORDERSTATUS);


CREATE SEQUENCE account_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE accountprofile_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE holding_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE order_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE quote_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
