-module(cbv_math).

-export([ eval/1
        ]).

eval(N) when is_number(N) -> ok(N);
eval({add, N1, N2}) ->          ok(unwrap(eval(N1)) + unwrap(eval(N2)));
eval({sub, N1, N2}) ->          ok(unwrap(eval(N1)) - unwrap(eval(N2)));
eval({mul, N1, N2}) ->          ok(unwrap(eval(N1)) * unwrap(eval(N2)));
eval({'div', N1, N2}) ->        ok(unwrap(eval(N1)) div unwrap(eval(N2)));
eval({pow, _N1, _N2}) ->        ok(1);
eval(_) -> {error, unsupported_expression }.

ok(V) -> {ok, V}.
unwrap({ok, V}) -> V.