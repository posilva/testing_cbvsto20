-module(cbv_inet_server_SUITE).

-include_lib("stdlib/include/assert.hrl").
-include_lib("common_test/include/ct.hrl").

-compile(export_all).


all() -> [
  server_created_test,
  request_ok_test,
  request_err_test,
  stats_test
].

init_per_testcase(_, Config) ->
  ServerPid = cbv_inet_server:start_link(),
  [{server_pid, ServerPid}| Config].

end_per_testcase(_, Config) ->
  {ok, Pid} = ?config(server_pid, Config),
  erlang:exit(Pid, normal),
  ok.

server_created_test(Config) ->
  {ok, Pid} = ?config(server_pid, Config),
  ?assert(is_pid(Pid)).

request_ok_test(_Config) ->
  ?assertMatch({ok, _}, cbv_inet_server:request("https://google.com")).

request_err_test(_Config) ->
  ?assertMatch({error, _}, cbv_inet_server:request("https://googlenon_existing.com")).

stats_test(_Config) ->
  ?assertMatch({ok, #{ fail := _Fail
   , success := _Success
   }}, cbv_inet_server:stats()).

