SET serveroutput on;

DECLARE

    t_combinations     INTEGER_MATRIX;
    r_input   INTEGER_ARRAY := INTEGER_ARRAY(1, 2, 3, 4);

    r_res INTEGER_ARRAY;
BEGIN
    t_combinations := PERMUTATION.VARIATION_MIT_WIEDERHOLUNG(R_INPUT,2);
    t_combinations := PERMUTATION.KOMBINATION_OHNE_WIEDERHOLUNG(R_INPUT,3);
    t_combinations := PERMUTATION.KOMBINATION_OHNE_WIEDERHOLUNG(R_INPUT,2);
    t_combinations := PERMUTATION.KOMBINATION_OHNE_WIEDERHOLUNG(R_INPUT,1);
    
END;