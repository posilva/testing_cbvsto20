-module(cbv_SUITE).

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

inet_request_test(Config) ->
  cbv_inet_server:request(Url).

inet_stats_test(Config) ->
  cbv_inet_server:stats().

zen() ->
  Url = "https://api.github.com/zen",
  inet_request(Url).
