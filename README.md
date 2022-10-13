# Go Gin-Gonic Project

## Getting Started

### Pre-Requisite

- AWS Account and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) version `2.x`.
- [Go](https://go.dev/doc/install) version `>= 1.19`.
- AWS [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) version `1.5x.x`.

### Install

Install required packages/dependencies by executing command:

```bash
go get .
```

### Test

To running test, execute the following commnad:

```bash
go test
```

### Run (Development Mode)

Start local development app by executing command:

```bash
go run main.go
```

The app will run at [http://localhost:8080](http://localhost:8080).

# Deployment

This project is intended to be deployed to [AWS Lambda](https://aws.amazon.com/lambda/). There are several ways to deploy Gin to AWS Lambda, both methods require [AWS Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html).

- The first method is using [lambda-web-adapter](https://github.com/awslabs/aws-lambda-web-adapter).
- Another method is using [lambda-go-api-proxy](https://github.com/awslabs/aws-lambda-go-api-proxy).

**Check out each branch of this repository to learn more about each deployment.**

> The project is hosted and working fine on AWS Lambda as it runs with HTTP 1.0/1.1.
>
> In a nutshell, Lambda will run if triggered by event(s). On such event(s), AWS will spawn up lightweight Virtual Machine, load and execute the user-defined Lambda function, return the computed response, and kill the VM. While [gRPC](https://grpc.io/), need an active server. So, until now it is possible to make Lambda a [gRPC](https://grpc.io/) client, but not as a [gRPC](https://grpc.io/) server.
>
> Please read [this article](https://aws.plainenglish.io/invoking-aws-lambda-with-grpc-protobuf-431483a869e8) to learn more about AWS Lambda with gRPC. [This coinbase blog](https://blog.coinbase.com/grpc-to-aws-lambda-is-it-possible-4b29a9171d7f) explains well the different approaches they tried to achieve for combining gRPC and Lambda.

## References

Here are the resources that might help to learn more about each deployment method:

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
- [AWS Serverless Application Model (SAM) Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html).
- [AWS lambda-web-adapter Documentation](https://github.com/awslabs/aws-lambda-web-adapter#aws-lambda-web-adapter).
- [AWS lambda-go-api-proxy Documentation](https://github.com/awslabs/aws-lambda-go-api-proxy#aws-lambda-go-api-proxy-).

If you have questions or found any problem let me know by opening issue - your feedback and contributions are welcome!
