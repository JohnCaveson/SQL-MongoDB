/*
Greer Goodman
Caleb Mann
??
??
*/
DROP TABLE VEHICLE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE ADDRESS CASCADE CONSTRAINTS;
DROP TABLE SALESPERSON CASCADE CONSTRAINTS;
DROP TABLE PERFORMANCEREPORT CASCADE CONSTRAINTS;
DROP TABLE SALE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERSURVEY CASCADE CONSTRAINTS;
DROP TABLE LEGALDOCUMENTATION CASCADE CONSTRAINTS;
DROP TABLE BILLOFSALE CASCADE CONSTRAINTS;
DROP TABLE CARSONLOT CASCADE CONSTRAINTS;
DROP TABLE PRICESTICKER CASCADE CONSTRAINTS;
/*


Table Creation


*/
CREATE TABLE VEHICLE (
        pk_VehicleID VARCHAR2(20) NOT NULL PRIMARY KEY,
        Make VARCHAR2(15) NOT NULL,
        Model VARCHAR2(20) NOT NULL,
        DateOfManufacture VARCHAR2(10) NOT NULL,
        PlaceOfManufacture VARCHAR2(10) NOT NULL,
        Cylinders INTEGER NOT NULL,
        Doors INTEGER NOT NULL,
        Weight INTEGER NOT NULL,
        Capacity INTEGER NOT NULL,
        Options VARCHAR2(15),
        Color VARCHAR2(15) NOT NULL,
        CurrentMileage INTEGER NOT NULL
    );
CREATE TABLE CUSTOMER (
        pk_CustomerID VARCHAR2(15) NOT NULL PRIMARY KEY,
        CustomerLastName VARCHAR2(10) NOT NULL,
        CustomerFirstName VARCHAR2(10) NOT NULL,
        ReferredBy VARCHAR2(20),
        DriverLicenseNumber INTEGER NOT NULL,
        InsurancePolicyNumber INTEGER NOT NULL
    );
CREATE TABLE SALESPERSON(
        pk_SalesPersonID VARCHAR2(15) NOT NULL PRIMARY KEY,
        LastName VARCHAR2(10) NOT NULL,
        FirstName VARCHAR2(10) NOT NULL,
        DateHired VARCHAR2(10) NOT NULL,
        DateReleased VARCHAR(10)
    );
CREATE TABLE ADDRESS(
        pk_AddressID VARCHAR2(20) NOT NULL PRIMARY KEY,
        Street VARCHAR2(20) NOT NULL,
        City VARCHAR2(15) NOT NULL,
        State VARCHAR2(2) NOT NULL,
        ZIP INTEGER NOT NULL,
        fk_CustomerID VARCHAR2(15) NOT NULL,
        fk_SalesPersonID VARCHAR2(15) NOT NULL,
        FOREIGN KEY (fk_CustomerID) REFERENCES CUSTOMER(pk_CustomerID),
        FOREIGN KEY (fk_SalesPersonID) REFERENCES SALESPERSON(pk_SalesPersonID)
    );
CREATE TABLE PERFORMANCEREPORT(
        SalesFromPreviousMonth FLOAT,
        CommissionEarned FLOAT,
        fk_SalesPersonID VARCHAR2(15),
        FOREIGN KEY (fk_SalesPersonID) REFERENCES SALESPERSON(pk_SalesPersonID)
    );
CREATE TABLE SALE(
        pk_SaleID VARCHAR2(10) NOT NULL PRIMARY KEY,
        PriceBeforeTax FLOAT NOT NULL,
        PriceAfterTax FLOAT NOT NULL,
        PaymentMethod VARCHAR2(6) NOT NULL,
        FinancingPlan VARCHAR2(60),
        WarrantyPlan VARCHAR2(30),
        CustomizationNotes VARCHAR2(60),
        SaleDate VARCHAR2(10) NOT NULL,
        fk_VehicleID VARCHAR2(20) NOT NULL,
        fk_CustomerID VARCHAR2(15) NOT NULL,
        fk_SalesPersonID VARCHAR2(15) NOT NULL,
        FOREIGN KEY (fk_VehicleID) REFERENCES VEHICLE(pk_VehicleID),
        FOREIGN KEY (fk_CustomerID) REFERENCES CUSTOMER(pk_CustomerID),
        FOREIGN KEY (fk_SalesPersonID) REFERENCES SALESPERSON(pk_SalesPersonID)
    );
CREATE TABLE CUSTOMERSURVEY(
        OpinionOfCar VARCHAR2(20),
        OpinionOfDealership VARCHAR2(20),
        OpinionOfSalesPerson VARCHAR2(20),
        OtherNotes VARCHAR2(20),
        fk_CustomerID VARCHAR2(15),
        FOREIGN KEY (fk_CustomerID) REFERENCES CUSTOMER(pk_CustomerID) 
    );
    
/*


Weak entities


*/
CREATE TABLE LegalDocumentation(
        ProofOfInsurance VARCHAR2(2) NOT NULL,
        StateSalesTax FLOAT NOT NULL,
        LicenseFee FLOAT NOT NULL,
        fk_CustomerID VARCHAR2(15) NOT NULL,
        fk_SaleID VARCHAR2(10) NOT NULL,
        FOREIGN KEY(fk_CustomerID) REFERENCES CUSTOMER(pk_CustomerID),
        FOREIGN KEY(fk_SaleID) REFERENCES SALE(pk_SaleID)
    );
CREATE TABLE BILLOFSALE(
        fk_SaleID VARCHAR2(10) NOT NULL,
        FOREIGN KEY(fk_SaleID) REFERENCES SALE(pk_SaleID)
    );
CREATE TABLE CARSONLOT(
        fk_VehicleID VARCHAR2(20) NOT NULL,
        DateDelivered VARCHAR2(10) NOT NULL,
        MileageWhenDelivered VARCHAR2(10) NOT NULL,
        FOREIGN KEY(fk_VehicleID) REFERENCES VEHICLE(pk_VehicleID)
    );
CREATE TABLE PRICESTICKER(
        fk_VehicleID VARCHAR2(20) NOT NULL,
        ListPrice INTEGER NOT NULL,
        FOREIGN KEY(fk_VehicleID) REFERENCES VEHICLE(pk_VehicleID)
    );