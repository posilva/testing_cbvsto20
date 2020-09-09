-module(cbv_math_server_SUITE).

-include_lib("common_test/include/ct.hrl").

-export([all/0, init_per_testcase/2, end_per_testcase/2]).

-export([
  some_test/1
]).

all() -> [some_test].

init_per_testcase(_, Config) ->
  Config.

end_per_testcase(_, _Config) ->
  ok.

some_test(Config) ->
  Config.
