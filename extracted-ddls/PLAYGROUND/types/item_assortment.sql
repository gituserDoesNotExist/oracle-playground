CREATE OR REPLACE TYPE "PLAYGROUND"."ITEM_ASSORTMENT" 
  AUTHID DEFINER
  AS
  OBJECT (N_TOTAL_WEIGHT NUMBER,
          N_TOTAL_VALUE NUMBER,
          R_ITEMS PLAYGROUND.ITEMS,
          CONSTRUCTOR FUNCTION ITEM_ASSORTMENT(P_R_ITEMS IN PLAYGROUND.ITEMS)
            RETURN SELF AS RESULT,
          MEMBER FUNCTION GET_TOTAL_VALUE
            RETURN NUMBER,
          MEMBER FUNCTION GET_TOTAL_WEIGHT
            RETURN NUMBER,
          MEMBER FUNCTION GET_ASSORTMENTS
            RETURN PLAYGROUND.ITEMS);
/
CREATE OR REPLACE TYPE BODY "PLAYGROUND"."ITEM_ASSORTMENT" 
  AS

    CONSTRUCTOR FUNCTION ITEM_ASSORTMENT(P_R_ITEMS IN PLAYGROUND.ITEMS)
      RETURN SELF AS RESULT
      IS
        CURRENT_ITEM PLAYGROUND.ITEM;
      BEGIN
        R_ITEMS := P_R_ITEMS;
        SELF.N_TOTAL_WEIGHT := 0;
        SELF.N_TOTAL_VALUE := 0;
        FOR IDX IN 1 .. SELF.R_ITEMS.count
        LOOP
          CURRENT_ITEM := SELF.R_ITEMS(IDX);
          SELF.N_TOTAL_WEIGHT := SELF.N_TOTAL_WEIGHT + CURRENT_ITEM.GET_WEIGHT();
          SELF.N_TOTAL_VALUE := SELF.N_TOTAL_VALUE + CURRENT_ITEM.GET_VALUE();
        END LOOP;
        RETURN;
      END;

    MEMBER FUNCTION GET_TOTAL_VALUE
      RETURN NUMBER
      IS
      BEGIN
        RETURN SELF.N_TOTAL_VALUE;
      END;

    MEMBER FUNCTION GET_TOTAL_WEIGHT
      RETURN NUMBER
      IS
      BEGIN
        RETURN SELF.N_TOTAL_WEIGHT;
      END;

    MEMBER FUNCTION GET_ASSORTMENTS
      RETURN PLAYGROUND.ITEMS
      IS
      BEGIN
        RETURN SELF.R_ITEMS;
      END GET_ASSORTMENTS;

  END;
/