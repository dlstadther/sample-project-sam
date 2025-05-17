# Sample Project SAM

AWS' Serverless Application Model (SAM) is a framework for building serverless applications on AWS.

This project is a sample structure and setup for a SAM project.

## Setup

```shell
uv add --group dev aws-sam-cli awscli
uv run sam init --runtime python3.12 --name sample_sam
# select "AWS Quick Start Templates" using "Hello World Example with Powertools for AWS Lambda", enabling all prompted features
```

# TODO
- [x] move `sample_sam` content up a level
  - decide what part of its README to keep (there is some helpful stuff in there) - maybe in a `SAM.md`?
- [x] complete sam-in-docker-compose setup
  - test ability to read `.python-version` in `docker-compose.yaml`
- [x] update `hello_world` lambda to use docker
- [ ] create non-hello-world lambda with RestApiGateway
- [ ] update template to use openapi.yaml
- [x] add tests
  - including `ruff`, `mypy`, `cfn-lint`, `pytest`, `pytest-cov`
  - should use `tox`?
- [ ] DRY test setup (`pyproject.toml` dev dependencies vs `tests/requirements.txt`; `test.dockerfile` vs local `uv`)
- [ ] update template to use lambda alias (apigateway routes + permissions) (to allow for provisioned concurrency respect)
