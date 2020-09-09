-module(cbv_math_server_SUITE).

-include_lib("common_test/include/ct.hrl").

-export([all/0, init_per_testcase/2, end_per_testcase/2]).

-export([
  simple_eval_test/1
]).

all() -> [some_test].

init_per_testcase(_, Config) ->
  Config.

end_per_testcase(_, _Config) ->
  ok.

simple_eval_test(Config) ->
  ?assertEqual(42, cbv_math:eval(42)).
