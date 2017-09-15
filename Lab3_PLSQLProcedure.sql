--------------------------------------------------------
--  File created - Saturday-June-24-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CSVOUT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "GOODMANG"."CSVOUT" 
(
    Manufacturer IN VARCHAR2,
    ModelNumber IN VARCHAR2,
    Category IN VARCHAR2,
    Cost IN NUMBER,
    ListPrice IN NUMBER,
    QuantityOnHand in NUMBER,
    TotalCost IN NUMBER,
    TotalListPrice IN NUMBER,
    TotalProfit IN NUMBER
)AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('"'||Manufacturer||'", "'||Modelnumber||'", "'||Category||'", "'||Cost||'", "'||ListPrice||'", "'||QuantityOnHand||'", "'||TotalCost||'", "'||TotalListPrice||'", "'||TotalProfit||'"');
END CSVOUT;

/
