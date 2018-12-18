CREATE OR REPLACE PROCEDURE "PLAYGROUND"."PRINT_MATRIX" (input_matrix IN INTEGER_MATRIX) 
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
