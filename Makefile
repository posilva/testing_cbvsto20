t:
	rebar3 as test ct --suite cbv_math_server_SUITE

c: t
	rebar3 cover -v --min_coverage=80