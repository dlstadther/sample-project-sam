BUILD_NUMBER ?= latest
DEFAULT_LAMBDA_FUNCTION := HelloWorldFunction
EVENT := $(DEFAULT_EVENT)
FUNCTION := $(DEFAULT_LAMBDA_FUNCTION)
IMAGE_NAME := sample-project-sam
IMAGE_NAME_TEST := $(IMAGE_NAME)-test

build-local:
	uv run sam build --cached --parallel

build-sam:
	docker compose build --build-arg PYTHON_VERSION=$$(cat .python-version)

build-test:
	docker buildx build \
	    --file test.dockerfile \
	    --tag $(IMAGE_NAME_TEST):$(BUILD_NUMBER) \
	    .

clean:
	docker rmi -f $(IMAGE_NAME):$(BUILD_NUMBER)
	docker rmi -f $(IMAGE_NAME_TEST):$(BUILD_NUMBER)

format:
	uv run ruff format --check .

init:
	curl -LsSf https://astral.sh/uv/install.sh | sh
	uv self update

install:
	uv sync

lint: lint-ruff lint-mypy lint-cfn

lint-cfn:
	uv run cfn-lint ./template.yaml
	uv run sam validate --template ./template.yaml

lint-mypy: build-test
	uv run mypy .

lint-ruff:
	uv run ruff check .

run-local: build-local build-sam
	# Use of `sam local start-api` lacks the ability to mount settings to the local application (including volumes and environment variables).
	# If wanting to run locally and authenticate to cloud services, we need to run `sam local start-api` within a docker container
	# where we can mount volumes (e.g. local creds files) and set environment variables (e.g. AWS_PROFILE).
	docker compose up

test: build-test
	docker run --rm $(IMAGE_NAME_TEST):$(BUILD_NUMBER) \
        pytest -vv tests

test-all: test format lint
