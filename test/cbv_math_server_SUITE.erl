-module(cbv_math_server_SUITE).

-include_lib("stdlib/include/assert.hrl").
-include_lib("common_test/include/ct.hrl").

-compile(export_all).


all() -> [
  server_created_test,
  eval_ok_test,
  eval_err_test,
  stats_test
].

init_per_testcase(_, Config) ->
  ServerPid = cbv_math_server:start_link(),
  [{server_pid, ServerPid}| Config].

end_per_testcase(_, Config) ->
  {ok, Pid} = ?config(server_pid, Config),
  erlang:exit(Pid, normal),
  ok.

server_created_test(Config) ->
  {ok, Pid} = ?config(server_pid, Config),
  ?assert(is_pid(Pid)).

eval_ok_test(_Config) ->
  ?assertMatch({ok, 42}, cbv_math_server:eval(42)).

eval_err_test(_Config) ->
  ?assertMatch({error, unsupported_expression}, cbv_math_server:eval(a)).

stats_test(_Config) ->
  ?assertMatch({ok, #{ fail := _Fail
   , success := _Success
   }}, cbv_math_server:stats()).

