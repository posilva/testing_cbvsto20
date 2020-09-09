-module(cbv_SUITE).

-include_lib("stdlib/include/assert.hrl").
-include_lib("common_test/include/ct.hrl").

-compile(export_all).


all() -> [
  inet_request_test,
  inet_stats_test,
  zen_test
].

init_per_testcase(_, Config) ->
  _ = application:ensure_all_started(cbv),
  Config.

end_per_testcase(_, _Config) ->
  ok = application:stop(cbv),
  ok.

inet_request_test(_Config) ->
  ?assertMatch({ok, _}, cbv:inet_request("https://httpstat.us/200")).

inet_stats_test(Config) ->
  ?assertMatch({ok, #{fail:=_,success:=_}}, cbv:inet_stats()),
  Config.

zen_test(Config) ->
  ?assertMatch({ok, _}, cbv:zen()),
  Config.