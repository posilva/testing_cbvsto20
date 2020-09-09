t:
	rebar3 as test ct #--suite=cbv_inet_server_SUITE --case=request_err_test

c: t
	rebar3 cover -v --min_coverage=80