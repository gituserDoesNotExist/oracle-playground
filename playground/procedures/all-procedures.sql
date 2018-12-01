--------------------------------------------------------
--  File created - Saturday-December-01-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PRINT_LIST
--------------------------------------------------------
set define off;

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
--------------------------------------------------------
--  DDL for Procedure PRINT_MATRIX
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PLAYGROUND"."PRINT_MATRIX" (input_matrix INTEGER_MATRIX) 
AUTHID DEFINER
IS 
    current_row INTEGER_ARRAY;
    current_element NUMBER;
BEGIN
  FOR cur_row_idx IN 1..input_matrix.count
  LOOP
    current_row := input_matrix(cur_row_idx);
    DBMS_OUTPUT.PUT('[');
    FOR current_column_idx IN 1..current_row.count
    LOOP
        current_element := current_row(current_column_idx);
        DBMS_OUTPUT.PUT(current_element);
        IF current_column_idx ~= current_row.count
        THEN
            DBMS_OUTPUT.PUT(' ');
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(']');
    
  END LOOP;
END PRINT_MATRIX;

/
--------------------------------------------------------
--  DDL for Procedure PRINT_NTT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PLAYGROUND"."PRINT_NTT" (
    r_input_tab IN   my_types.number_table
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
