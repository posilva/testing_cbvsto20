t:
	rebar3 as test ct

c: t
	rebar3 cover -v --min_coverage=80