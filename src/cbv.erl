-module(cbv).

-export([ inet_request/1
        , inet_stats/0
        , zen/0
        ]).

inet_request(Url) ->
  cbv_inet_server:request(Url).

inet_stats() ->
  cbv_inet_server:stats().

zen() ->
  Url = "https://api.github.com/zen",
  inet_request(Url).
