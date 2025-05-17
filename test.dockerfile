# Must be built from the root of the repo
FROM python:3.12-slim

# Application - Requirements
COPY ./hello_world/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./tests/requirements.txt ./requirements-test.txt
RUN pip install --no-cache-dir -r requirements-test.txt

# Application
COPY ./pyproject.toml ./pyproject.toml
COPY ./hello_world ./hello_world
COPY ./tests ./tests

# Entrypoint
CMD ["pytest", "-vv", "tests"]
