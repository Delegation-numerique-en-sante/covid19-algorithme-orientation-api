all: test

clean:
	rm -rf _build
	rm -rf deps

deps:
	mix local.hex --force
	mix local.rebar --force

install:
	mix do deps.get, compile
	npm install -g api-spec-converter

compile:
	mix compile

serve:
	iex --erl "+A 64 +K true +Q 65536 +stbt db +zdntgc 10" -S mix phx.server

start:
	MIX_ENV=prod _build/prod/rel/covid19_orientation/bin/covid19_orientation start

format:
	mix format

lint:
	mix credo --strict

test: format lint
	mix test

release:
	MIX_ENV=prod mix release --overwrite

gen-spec:
	mix covid19_orientation.open_api_3.gen_spec
	api-spec-converter --from=openapi_3 --to=openapi_3 --syntax=yaml --check openapi3.json > openapi3.yaml
