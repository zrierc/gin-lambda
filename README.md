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

# Deploy to lambda-web-adapter (zip/package)

- Setup [AWS Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

- Create or clone Go/Gin project.

- Since we build app in zip packages, we need `Makefile` file for build app and call it inside `template.yaml` as build method.

  ```makefile
  # Makefile

  build-GinFunction:
    GOOS=linux CGO_ENABLED=0 go build -o bootstrap .
    mv bootstrap $(ARTIFACTS_DIR)/bootstrap
  ```

- A file called `template.yaml` at the root of your project is used to tell AWS SAM to define AWS resources, including Lambda functions and an API Gateway.

  There are additional steps that need to be taken when we want to deploy using zip packages:

  - Attach Lambda Web Adapter layer to your function inside `template.yaml`
    - x86_64: `arn:aws:lambda:${AWS::Region}:753240598075:layer:LambdaAdapterLayerX86:7`
    - arm64: `arn:aws:lambda:${AWS::Region}:753240598075:layer:LambdaAdapterLayerArm64:7`
  - Configure Lambda environment variable `AWS_LAMBDA_EXEC_WRAPPER` to `/opt/bootstrap`. You can also add this variable inside `template.yaml` like code below:

    ```yaml
    # template.yaml

    ...

    resources:
      myFunction:
        Environment:
          variables:
            AWS_LAMBDA_EXEC_WRAPPER: /opt/bootstrap
        ...
      ...
    ```

  > If you want to customize or adding another resources, you can check [AWS SAM references](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-specification.html) or you can check out [example gin application](https://github.com/awslabs/aws-lambda-web-adapter/tree/main/examples/gin-zip) that provided by AWS Lambda Web Adapter repository.

- To build and deploy your application for the first time, run the following in your shell:

  ```bash
  sam build
  sam deploy --guided
  ```

  The command `sam build` compiles the application, and prepares a deployment package in the `.aws-sam` sub-directory.

  > With AWS Serverless Application Model (SAM), you can also invoke or test your lambda function locally. See [AWS SAM documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-test-and-debug.html) to learn more.

## References

If you get an error during the deployment proccess or want to learn more about lambda-web-adapter and AWS Serverless Application Model (SAM), take a look at the following resources:

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
- [AWS Serverless Application Model (SAM) Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html).
- [AWS lambda-web-adapter Documentation](https://github.com/awslabs/aws-lambda-web-adapter#aws-lambda-web-adapter).
- [Sample gin application built with lambda web adapter](https://github.com/awslabs/aws-lambda-web-adapter/tree/main/examples/gin-zip).

If you have questions or found any problem let me know by opening issue - your feedback and contributions are welcome!
