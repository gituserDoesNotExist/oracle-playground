CREATE OR REPLACE PACKAGE "PLAYGROUND"."PERMUTATION" AUTHID DEFINER
  IS
  -- Ziehen mit Zurücklegen, mit Beachtung der Reihenfolge entspricht einer Variation mit Wiederholung
  FUNCTION VARIATION_MIT_WIEDERHOLUNG(R_POOL_TO_PICK_FROM IN INTEGER_ARRAY,
                                      N_NUMBER_OF_PICKS   IN NUMBER)
    RETURN INTEGER_MATRIX;

  -- Ziehen ohne Zurücklegen und ohne Beachtung der Reihenfolge entspricht einer Kombinatoin ohne Wiederholung
  FUNCTION KOMBINATION_OHNE_WIEDERHOLUNG(R_POOL_TO_PICK_FROM INTEGER_ARRAY,
                                         N_NUMBER_OF_PICKS   NUMBER)
    RETURN INTEGER_MATRIX;

END PERMUTATION;
/
