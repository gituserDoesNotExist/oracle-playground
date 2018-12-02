CREATE OR REPLACE PROCEDURE "PLAYGROUND"."PRINT_LIST" (
    r_input_list INTEGER_ARRAY
)
    AUTHID definer
IS
BEGIN
    dbms_output.put_line('list:');
    FOR idx IN 1..r_input_list.count LOOP
        dbms_output.put(r_input_list(idx));
        dbms_output.put(' ');
    END LOOP;
    dbms_output.new_line;
END;
/
