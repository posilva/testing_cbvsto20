-module(testex).

-export([reverse/1]).

-include_lib("eunit/include/eunit.hrl").

reverse([]) -> [];
reverse([H|T]) ->
  [reverse(T)|H].

reverse_empty_test() ->
  [] = reverse([]).
reverse_one_test() ->
  [1] = reverse([1]).
reverse_many_test() ->
  [3,2,1] = reverse([1,2,3]).
