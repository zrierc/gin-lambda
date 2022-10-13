# Go Gin-Gonic Project

## Getting Started

### Pre-Requisite

- AWS Account and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) version `2.x`.
- [Go](https://go.dev/doc/install) version `>= 1.19`.
- AWS [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) version `1.5x.x`.
- Docker.

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

# Deploy to lambda-web-adapter (container)

- Setup [AWS Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

- Create or clone Go/Gin project.

- Inside your `Dockerfile` add one line to copy Lambda Web Adapter binary to /opt/extensions inside your container.

  ```Dockerfile
  ...

  COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.5.0 /lambda-adapter /opt/extensions/lambda-adapter

  ...
  ```

  By default Lambda Web Adapter assumes the web app is listening on port 8080. If your app is running in another port, you can specify the port by adding environment variable called `PORT` inside `Dockerfile`.

  > Lambda Web Adapter provides [custom configuration](https://github.com/awslabs/aws-lambda-web-adapter#configurations) that can be configured via environment variables.

- A file called `template.yaml` at the root of your project is used to tell AWS SAM to define AWS resources, including Lambda functions and an API Gateway.

  > If you want to customize or adding another resources, you can check [AWS SAM references](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-specification.html) or you can check out [example gin application](https://github.com/awslabs/aws-lambda-web-adapter/tree/main/examples/gin) that provided by AWS Lambda Web Adapter repository.

- Build your application by executing this commands:

  ```bash
  aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws

  sam build
  ```

  This command compiles the application, create image and prepares a deployment package in the `.aws-sam` sub-directory.

- To deploy your application for the first time, run the following in your shell:

  ```bash
  sam deploy --guided
  ```

  > With AWS Serverless Application Model (SAM), you can also invoke or test your lambda function locally. See [AWS SAM documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-test-and-debug.html) to learn more.

## References

If you get an error during the deployment proccess or want to learn more about lambda-web-adapter and AWS Serverless Application Model (SAM), take a look at the following resources:

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
- [AWS Serverless Application Model (SAM) Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html).
- [AWS lambda-web-adapter Documentation](https://github.com/awslabs/aws-lambda-web-adapter#aws-lambda-web-adapter).
- [Sample gin application built with lambda web adapter](https://github.com/awslabs/aws-lambda-web-adapter/tree/main/examples/gin).

If you have questions or found any problem let me know by opening issue - your feedback and contributions are welcome!
