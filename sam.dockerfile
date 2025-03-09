ARG PYTHON_VERSION="null"
FROM python:${PYTHON_VERSION}-slim

ENV \
    SAM_DIR="/sam"
WORKDIR ${SAM_DIR}

# Install UV
ENV \
    # UV_LINK_MODE - silences warnings about not being able to use hard links since the cache and sync target are on separate file systems
    UV_LINK_MODE=copy
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install dependencies (specifically for the SAM CLI)
COPY pyproject.toml uv.lock ${SAM_DIR}/
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync
