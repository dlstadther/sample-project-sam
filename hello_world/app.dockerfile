# Must be built from the root of the repo
##################################
# PYTHON BASE
# configure shared settings for all stages
##################################
FROM public.ecr.aws/lambda/python:3.12 AS python-base


##################################
# BUILDER BASE
# build dependencies and virtualenv
##################################
FROM python-base AS builder-base

# Application - Requirements
COPY ./hello_world/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


##################################
# PRODUCTION
# final image used for runtime
##################################
FROM python-base AS production

# System Dependencies
# RUN dnf install -y \
#         ??? \
#     && \
#     dnf clean all -y && \
#     rm -rf /var/cache/dnf

# Copy python environment from builder-base
COPY --from=builder-base /var/lang/lib/python3.12/ /var/lang/lib/python3.12/

# Application
COPY ./hello_world ./hello_world

# Entrypoint
CMD ["hello_world.app.lambda_handler"]
