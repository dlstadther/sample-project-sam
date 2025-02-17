# Sample Project SAM

AWS' Serverless Application Model (SAM) is a framework for building serverless applications on AWS.

This project is a sample structure and setup for a SAM project.

## Setup

```shell
uv add --group dev aws-sam-cli awscli
uv run sam init --runtime python3.12 --name sample_sam
# select "AWS Quick Start Templates" using "Hello World Example with Powertools for AWS Lambda", enabling all prompted features
```
