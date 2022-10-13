FROM golang:1.19-alpine AS builder

WORKDIR /tmp/gin

RUN apk add --no-cache git

COPY . .

# Install deps and build app
RUN go mod download
RUN GOOS=linux CGO_ENABLED=0 go build -o bootstrap .


FROM alpine:3.9

RUN apk add ca-certificates

# Add lambda-web-adapter
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.5.0 /lambda-adapter /opt/extensions/lambda-adapter

COPY --from=builder /tmp/gin/bootstrap /app/bootstrap

ENV GIN_MODE=release
EXPOSE 8080

CMD ["/app/bootstrap"]