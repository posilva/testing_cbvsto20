-module(tree).

-export([serialise/1, deserialise/1]).

-include_lib("eunit/include/eunit.hrl").

%%------------------------------------------------------------------------------

serialise({leaf,N}) -> [2,N];
serialise({node,T1,T2}) ->
    L1 = [Size1|_] = serialise(T1),
    [Size2 | L2] = serialise(T2),
    [Size1+Size2|L1++L2].

deserialise([_|Ls]) -> list_to_tree(Ls).
list_to_tree([2,N]) -> {leaf, N};
list_to_tree([N]) -> {leaf, N};
list_to_tree([M|Rest]) ->
    {Code1, Code2} = lists:split(M-1, Rest),
    {node, list_to_tree(Code1),
           list_to_tree(Code2)}.

%%------------------------------------------------------------------------------

-ifdef(TEST).

leaf() -> {leaf,ant}.
tree() ->
  {node, {node, {leaf, cat},
                {node, {leaf, dog},
                       {leaf, emu}}},
         {leaf, fish}}.

%% Sanity checks
leaf_test() ->
    ?assertEqual(leaf(), deserialise(serialise(leaf()))).
node_test() ->
    ?assertEqual(tree(), deserialise(serialise(tree()))).

%% Test the format itself
leaf_value_test() ->
    ?assertEqual([2,ant], serialise(leaf())).
node_value_test() ->
    ?assertEqual([8,6,2,cat,2,dog,emu,fish],
                 serialise(tree())).

%% test that the function does die on incorrect input
leaf_negative_test() ->
    ?assertError(function_clause, list_to_tree([1,ant])).
node_negative_test() ->
    ?assertError(function_clause, list_to_tree([8,6,2,cat,2,dog,emu,fish])).

-endif.
