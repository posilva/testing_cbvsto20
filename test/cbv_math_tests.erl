-module(cbv_math_tests).

-include_lib("eunit/include/eunit.hrl").

num_test() ->
  ?assertEqual(42, cbv_math:eval(42)).
