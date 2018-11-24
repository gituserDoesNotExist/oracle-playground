SET SERVEROUTPUT ON;

DECLARE
    TYPE names_array IS VARRAY(3) OF VARCHAR2(10);
    
    names names_array;
    total NUMBER(1);
BEGIN
    names := names_array('name1','name2','name3');
    total := names.count;
    FOR idx IN 1..total
    LOOP
        dbms_output.put_line(names(idx));
    END LOOP;   
END;
/
DECLARE
    result NUMBER(10);
BEGIN
    result := add_numbers(1,10);
    dbms_output.put_line(result);
END;
/