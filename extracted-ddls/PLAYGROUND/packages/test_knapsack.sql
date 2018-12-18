CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_KNAPSACK" AUTHID DEFINER AS

  -- %suite


  -- %test(get maximum value for given items and knapsack capacity)
  PROCEDURE GET_BEST_VALUE;

  -- %test(no items in store - returns zero)
  PROCEDURE GET_BEST_VALUE_STORE_EMPTY;

  -- %test(no capacity - returns zero)
  PROCEDURE GET_BEST_VALUE_NO_CAPACITY;

END TEST_KNAPSACK;
/
