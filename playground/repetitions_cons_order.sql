
DECLARE
    n_numberOfPicks CONSTANT NUMBER := 8;
    
    n_res number;
    t_input my_types.my_list := my_types.my_list(1,2,3,4,5,6,7,8,9,10);
BEGIN
       
    n_res := permutation.repeat_cons_order(t_input, n_numberOfPicks);
END;
