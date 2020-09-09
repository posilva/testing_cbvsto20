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
  %% There is no need to use no_link in this case
  meck:new(httpc, [passthrough]),
  ServerPid = cbv_inet_server:start_link(),
  [{server_pid, ServerPid}| Config].

end_per_testcase(_, Config) ->
  meck:unload(httpc),
  {ok, Pid} = ?config(server_pid, Config),
  gen_server:stop(Pid),
  ok.

server_created_test(Config) ->
  {ok, Pid} = ?config(server_pid, Config),
  ?assert(is_pid(Pid)).

request_ok_test(_Config) ->
  ExpectedBody = <<"request_ok_test">>,
  meck:expect(httpc, request, fun(_, _, _, _) -> {ok, {200, ExpectedBody}}  end),
  ?assertMatch({ok, ExpectedBody}, cbv_inet_server:request("https://google.com")),
  meck:delete(httpc, request, 4).

request_err_test(_Config) ->
  ExpectedBody = <<"request_err_test">>,
  meck:expect(httpc, request, fun(_, _, _, _) -> {ok, {500, ExpectedBody}}  end),
  ?assertMatch({error, _}, cbv_inet_server:request("https://googlenon_existing.com")),
  meck:delete(httpc, request, 4).

stats_test(_Config) ->
  ?assertMatch({ok, #{ fail := _Fail
   , success := _Success
   }}, cbv_inet_server:stats()).

