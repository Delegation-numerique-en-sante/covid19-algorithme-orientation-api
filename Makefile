all: test

clean:
	rm -rf _build
	rm -rf deps

compile:
	mix local.hex --force
	mix local.rebar --force

install:
	mix do deps.get, compile
	npm install -g api-spec-converter

serve:
	mix phx.server

format:
	mix format

lint:
	mix credo --strict

test: format lint
	mix test

gen-spec:
	mix covid19_orientation.open_api_3.gen_spec
	api-spec-converter --from=openapi_3 --to=openapi_3 --syntax=yaml --check openapi3.json > openapi3.yaml
