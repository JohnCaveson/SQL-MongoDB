DROP TABLE AMOUNT;
DROP TABLE RATE;
DROP TABLE ROOM;
DROP TABLE CUSTOMER;
DROP TABLE HOTEL;
DROP TABLE LOCATION;
Create Table Location(
                  Location_ID varchar2(20) not null,
                  Customer_ID varchar2(20) not null,
                  StreetAddress varchar2(20),
                  City varchar2(20),
                  State varchar2(20),
                  Zip varchar2(20),
                  Constraint Location_PK Primary Key (Location_ID)
);
CREATE TABLE HOTEL(
                   HOTELID VARCHAR2(20) PRIMARY KEY,
                   NAME VARCHAR2(20),
                   RATING INTEGER
);
                   
CREATE TABLE RATE(
                  RATECODE VARCHAR2(20) NOT NULL PRIMARY KEY,
                  TOTAL NUMBER(2,3) NOT NULL, 
                  DESCRIPT VARCHAR2(20), 
                  CONDITIONS VARCHAR2(20)
);

CREATE TABLE AMOUNT(
                  RATECODE VARCHAR2(20) NOT NULL,
                  ROOMNUMBER INTEGER NOT NULL,
                  CHARGES INTEGER NOT NULL,
                  CONSTRAINT PK_AMOUNT PRIMARY KEY (RATECODE, ROOMNUMBER)
);
CREATE TABLE customer(
                  customer_ID VARCHAR2(20) PRIMARY KEY,
                  firstName VARCHAR2(20),
                  lastName VARCHAR2(20),
                  isPreferred INTEGER,
                  location_ID VARCHAR2(20),
                  CONSTRAINT fk_cust_location FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);
CREATE TABLE room(
                  roomNumber integer PRIMARY KEY,
                  isAccessible INTEGER,
                  beds INTEGER,
                  maximumGuests INTEGER,
                  customer_ID VARCHAR2(20),
                  hotelID VARCHAR2(20),
                  CONSTRAINT fk_room_hotel FOREIGN KEY (HOTELID) REFERENCES HOTEL(HOTELID),
                  CONSTRAINT fk_room_cust FOREIGN KEY (customer_ID) REFERENCES customer(customer_ID)
);