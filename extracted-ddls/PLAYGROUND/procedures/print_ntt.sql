CREATE OR REPLACE PROCEDURE "PLAYGROUND"."PRINT_NTT" (
    r_input_tab IN   PLAYGROUND.INTEGER_ARRAY
) AUTHID DEFINER AS
BEGIN
    dbms_output.put_line('nested table:');
    FOR idx IN r_input_tab.first..r_input_tab.last LOOP
        IF r_input_tab.exists(idx) THEN
            dbms_output.put(r_input_tab(idx));
            dbms_output.put(' ');
        END IF;
    END LOOP;
    dbms_output.new_line;
END print_ntt;
/
