CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_ALL_KNAPSACK" AUTHID DEFINER
  AS

  -- %suite

  -- %test(create SUB_SOLUTION - success)
  PROCEDURE TEST_SUB_SOLUTION_CREATE;

  -- %test(get maximum value for given items and knapsack capacity)
  PROCEDURE TEST_GET_BEST_VALUE;

END TEST_ALL_KNAPSACK;
/
