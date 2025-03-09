build-local:
	uv run sam build --cached --parallel

init:
	curl -LsSf https://astral.sh/uv/install.sh | sh
	uv self update

install:
	uv sync

run-local: build-local
	# Use of `sam local start-api` lacks the ability to mount settings to the local application (including volumes and environment variables).
	# If wanting to run locally and authenticate to cloud services, we need to run `sam local start-api` within a docker container
	# where we can mount volumes (e.g. local creds files) and set environment variables (e.g. AWS_PROFILE).
	docker compose build --build-arg PYTHON_VERSION=$$(cat .python-version) && \
	docker compose up
