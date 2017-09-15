SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE REPORTS AS
    PROCEDURE PHOTOGRAPHERSCHED;
    PROCEDURE WEEKLYSCHED(DATE1 IN VARCHAR2, DATE2 IN VARCHAR2);
	PROCEDURE CLIENT;
    PROCEDURE PAT(PNAME IN VARCHAR2, DATE1 IN VARCHAR2);
    --POCEDURE REPROPOSAL;
END REPORTS;
/

CREATE OR REPLACE PACKAGE BODY REPORTS AS
/*
    PHOTOGRAPHER SCHEDULE PROCEDURE
*/
PROCEDURE PHOTOGRAPHERSCHED AS
    CURSOR C1 IS 
         SELECT b.EVENT_ID,
                EVENT_TYPE,
                LOCATION,
                CONTRACT_ID,
                DESCRIPTION,
                PHOTOGRAPHER_ID,
                STAFF_NAME
                FROM BOOKING b
                INNER JOIN CONTRACT c ON b.EVENT_ID=c.EVENT_ID
                INNER JOIN PHOTOGRAPHER p ON c.PHOTOGRAPHER_ID=p.STAFF_ID
                ORDER BY PHOTOGRAPHER_ID;
                
         
    
    cRow C1%ROWTYPE;    
BEGIN
    OPEN C1;
    FETCH C1 INTO cRow;
    DBMS_OUTPUT.PUT_LINE('Contract ID||Location||Description||Event Type||Staff Name');
    LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(cRow.CONTRACT_ID||' || '||cRow.LOCATION||' || '||cRow.DESCRIPTION||' || '||cRow.EVENT_TYPE||' || '||cRow.STAFF_NAME);
        FETCH C1 INTO cRow;
    END LOOP;
    CLOSE C1;
END PHOTOGRAPHERSCHED;
--CLIENT REPORT
PROCEDURE CLIENT AS
    CURSOR C1 IS 
        SELECT	c.CLIENT_ID,
				c.ORDER_ID,
				c.CLIENT_NAME,
				c.CLIENT_EMAIL,
				c.ADDRESS_ID,
				p.PACKAGE_NAME,
				p.PACKAGE_PRICE,
				co.CONTRACT_ID,
				co.LOCATION,
				co.SERVICE_DATE,
				co.SERVICE_TIME,
				co.PHOTOGRAPHER_ID
				
        FROM CLIENT c
        INNER JOIN PACKAGE_ORDER p ON c.ORDER_ID=p.ORDER_ID
		INNER JOIN CONTRACT co ON c.CLIENT_ID=co.CLIENT_ID
        ORDER BY CLIENT_ID;
    cRow C1%ROWTYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Client  ID, Order ID, Client Name,  Client E-Mail | Address ID, Package Name, Package Price,  Contract ID,  Location, Service Date, Service Time, Photographer Name ');
    OPEN C1;
    LOOP
        FETCH C1 INTO cRow;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(	cRow.CLIENT_ID
								||', '||cRow.ORDER_ID
								||', '||cRow.CLIENT_NAME
								||' | '||cRow.CLIENT_EMAIL
								||', '||cRow.ADDRESS_ID
								||', '||cRow.PACKAGE_NAME
								||', '||cRow.PACKAGE_PRICE
								||', '||cRow.CONTRACT_ID
								||', '||cRow.LOCATION
								||', '||cRow.SERVICE_DATE
								||', '||cRow.SERVICE_TIME
								||', '||cRow.PHOTOGRAPHER_ID);
    END LOOP;
    CLOSE C1;
END CLIENT;

/*
    Weekly Schedule Procedure
*/
PROCEDURE WEEKLYSCHED(DATE1 IN VARCHAR2,DATE2 IN VARCHAR2) AS
    CURSOR C1 IS 
        SELECT EVENT_TYPE,
            SERVICE_TIME,
            SERVICE_DATE,
            DUE_DATE,
            AMOUNT
        FROM BOOKING b
        INNER JOIN CONTRACT c ON b.EVENT_ID=c.EVENT_ID
        INNER JOIN PAYMENT p ON c.CLIENT_ID=p.CLIENT_ID
        WHERE SERVICE_DATE BETWEEN DATE1 AND DATE2
        ORDER BY SERVICE_TIME;
    cRow C1%ROWTYPE;
BEGIN
    OPEN C1;
    FETCH C1 INTO cRow;
    DBMS_OUTPUT.PUT_LINE('========= Week of '||DATE1||' - '||DATE2||'==========');
    DBMS_OUTPUT.PUT_LINE('Event Type||Time of Shooting||Pay by||Amount Due');
    LOOP
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(cRow.EVENT_TYPE||' || '||cRow.SERVICE_TIME||' || '||cRow.DUE_DATE||' || $'||cRow.AMOUNT);
        FETCH C1 INTO cRow;
    END LOOP;
    CLOSE C1;
END WEEKLYSCHED;
PROCEDURE PAT(PNAME IN VARCHAR2, DATE1 IN VARCHAR2) AS
CURSOR C1 IS
    SELECT p.STAFF_NAME,
           TIMEAVAILABLE,
           SERVICE_DATE,
           PHOTOGRAPHER_ID,
           STAFF_ID
           FROM PHOTOGRAPHER p
           INNER JOIN CONTRACT c ON p.STAFF_ID = c.PHOTOGRAPHER_ID
           WHERE STAFF_NAME = PNAME AND SERVICE_DATE = DATE1;
           
cRow C1%ROWTYPE;
BEGIN
           OPEN C1;
           FETCH C1 INTO cRow;
           IF cRow.PHOTOGRAPHER_ID=cRow.STAFF_ID THEN
                DBMS_OUTPUT.PUT_LINE('Time available for '||cRow.STAFF_NAME||' is '||cRow.TIMEAVAILABLE);
           ELSE
                DBMS_OUTPUT.PUT_LINE(PNAME||' does not work on '|| DATE1);
           END IF;
           CLOSE C1;
END PAT;
END REPORTS;
/

--EXEC REPORTS.PHOTOGRAPHERSCHED;
                        /*Input desired date range here*/
--EXEC REPORTS.WEEKLYSCHED('2017-10-18','2017-11-11');
--EXEC REPORTS.CLIENT;
--EXEC REPORTS.PAT('Davis, Liz K.','2017-11-12');