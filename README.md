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

# Deployment using API-Proxy

## Pre-Requisite

There are several configurations that need to be done to make [lambda-go-api-proxy](https://github.com/awslabs/aws-lambda-go-api-proxy) work properly. Check [the guide for Gin Framework](https://github.com/awslabs/aws-lambda-go-api-proxy#gin) provided by its official documentation or simply you can follow the steps below:

- Create or clone Go/Gin project.

- Install required dependencies for [lambda-go-api-proxy](https://github.com/awslabs/aws-lambda-go-api-proxy#getting-started). First, install the Lambda go libraries:

  ```bash
  go get github.com/aws/aws-lambda-go/events
  go get github.com/aws/aws-lambda-go/lambda
  ```

  Next, install the core library:

  ```bash
  go get github.com/awslabs/aws-lambda-go-api-proxy/gin
  ```

- To use with the Gin framework, following the instructions from the [Lambda documentation](https://docs.aws.amazon.com/lambda/latest/dg/go-programming-model-handler-types.html), declare a Handler method for the main package.

  ```go
  // main.go
  ...

  func Handler(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
    return ginLambda.ProxyWithContext(ctx, req)
  }
  ```

  The `ProxyWithContext` method is then used to translate requests and responses.

- Declare a `ginadapter.GinLambda` object in the global scope, and initialize it in the `init` function, adding or call all API methods.

  ```go
  // main.go
  ...

  var ginLambda *ginadapter.GinLambda

  func init(){
    log.Printf("Gin cold start")

    r := setupRouter()

    ginLambda = ginadapter.New(r)
  }
  ```

- Create entry point that runs your Lambda function code inside `main` function.

  ```go
  // main.go
  ...

  func main() {
    lambda.Start(Handler)
  }
  ```

  The code above will tell Lambda to execute the `Handler` function declared before.

## Deploy

- Setup [AWS Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

- Since we build app in zip packages, we need to create `Makefile` file for build app and call it inside `template.yaml` as build method.

  ```makefile
  # Makefile

  build-GinFunction:
    GOOS=linux CGO_ENABLED=0 go build -o bootstrap .
    mv bootstrap $(ARTIFACTS_DIR)/bootstrap
  ```

- A file called `template.yaml` at the root of your project is used to tell AWS SAM to define AWS resources, including Lambda functions and an API Gateway.

  > If you want to customize or adding another resources, you can check [AWS SAM references](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-specification.html).

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
- [AWS lambda-go-api-proxy Documentation](https://github.com/awslabs/aws-lambda-go-api-proxy).

If you have questions or found any problem let me know by opening issue - your feedback and contributions are welcome!
