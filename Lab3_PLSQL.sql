SET SERVEROUTPUT ON;

DECLARE
        counter NUMBER;
        total NUMBER;
        
        --Sales cursor for monthly income from rentals
        CURSOR Sales_Cursor IS
                SELECT RENTAL.PAYMENTMETHOD, EXTRACT (MONTH FROM RENTAL.RENTDATE)AS MONF, SUM(RENTITEM.RENTFEE)AS ALLRENTS
                FROM ALLPOWDER.RENTAL
                INNER JOIN ALLPOWDER.RENTITEM ON ALLPOWDER.RENTAL.RENTID=ALLPOWDER.RENTITEM.RENTID
                GROUP BY RENTAL.PAYMENTMETHOD, EXTRACT(MONTH FROM RENTAL.RENTDATE)
                ORDER BY EXTRACT(MONTH FROM RENTAL.RENTDATE);
                
        SALE_REC Sales_Cursor%ROWTYPE;       
        
        --Customer cursor for discounts above a skill level of 5       
        CURSOR Cust_Cursor IS
                SELECT CUSTOMER.LASTNAME, CUSTOMER.FIRSTNAME, CUSTOMER.EMAIL, CUSTOMERSKILL.SKILLLEVEL
                FROM ALLPOWDER.CUSTOMER
                INNER JOIN ALLPOWDER.CUSTOMERSKILL ON ALLPOWDER.CUSTOMER.CUSTOMERID=ALLPOWDER.CUSTOMERSKILL.CUSTOMERID
                WHERE ALLPOWDER.CUSTOMERSKILL.SKILLLEVEL >= 6
                ORDER BY ALLPOWDER.CUSTOMERSKILL.SKILLLEVEL, ALLPOWDER.CUSTOMER.LASTNAME, ALLPOWDER.CUSTOMER.FIRSTNAME ASC;
       
        CUST_REC Cust_Cursor%ROWTYPE;

BEGIN 
        /*
        
        INFORMATION ABOUT CUSTOMERS
        
        */
        OPEN Cust_Cursor;
        LOOP
            FETCH Cust_Cursor INTO CUST_REC;
            EXIT WHEN Cust_Cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Name: ' || CUST_REC.LASTNAME || ', ' || CUST_REC.FIRSTNAME);
            DBMS_OUTPUT.PUT_LINE('Email: ' || CUST_REC.EMAIL);
            
            IF CUST_REC.SKILLLEVEL = 10 THEN
                DBMS_OUTPUT.PUT_LINE('Half-Pipe Rating: **********');
            ELSIF CUST_REC.SKILLLEVEL = 9 THEN
                DBMS_OUTPUT.PUT_LINE('Half-Pipe Rating: *********');
            ELSIF CUST_REC.SKILLLEVEL = 8 THEN
                DBMS_OUTPUT.PUT_LINE('Half-Pipe Rating: ********');
            ELSIF CUST_REC.SKILLLEVEL = 7 THEN
                DBMS_OUTPUT.PUT_LINE('Half-Pipe Rating: *******');
            ELSIF CUST_REC.SKILLLEVEL = 6 THEN
                DBMS_OUTPUT.PUT_LINE('Half-Pipe Rating: ******');    
            ELSE
                DBMS_OUTPUT.PUT_LINE('');
            END IF;
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
        CLOSE Cust_Cursor;     
        
        /*
        
        SALES OUTPUT FOR EACH MONTH AND TOTALS
        
        */
        OPEN Sales_Cursor;
        counter := 0;
        FETCH Sales_Cursor INTO SALE_REC;
         WHILE counter < 5 LOOP
         total := 0;
            CASE
                WHEN SALE_REC.MONF = 1 THEN 
                 DBMS_OUTPUT.PUT_LINE('January Rentals----------');
                WHEN SALE_REC.MONF = 2 THEN 
                 DBMS_OUTPUT.PUT_LINE('February Rentals----------');
                WHEN SALE_REC.MONF = 3 THEN 
                 DBMS_OUTPUT.PUT_LINE('March Rentals----------');
                WHEN SALE_REC.MONF = 11 THEN 
                 DBMS_OUTPUT.PUT_LINE('November Rentals----------');
                WHEN SALE_REC.MONF = 12 THEN 
                 DBMS_OUTPUT.PUT_LINE('December Rentals----------');
                ELSE
                     EXIT;
            END CASE;
               FOR i in 0..6 LOOP
                    DBMS_OUTPUT.PUT_LINE(SALE_REC.PAYMENTMETHOD || ':  ' || to_char(SALE_REC.ALLRENTS,'$9,999'));
                    total := total + SALE_REC.ALLRENTS;
                    FETCH Sales_Cursor INTO SALE_REC;
                END LOOP;
        DBMS_OUTPUT.PUT_LINE('______________________');
        DBMS_OUTPUT.PUT_LINE('Total Rentals: ' || to_char(total,'$99,999'));
        DBMS_OUTPUT.PUT_LINE(' ');
        counter := counter +1;
    END LOOP;
    
    
END;
/