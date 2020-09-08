%%%-------------------------------------------------------------------
%% @doc cbv public API
%% @end
%%%-------------------------------------------------------------------

-module(cbv_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    cbv_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
