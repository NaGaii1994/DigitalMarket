FROM golang:1.19.3-alpine3.16 as dev

ENV ROOT=/go/src/app
ENV CGO_ENABLED 0
WORKDIR ${ROOT}

RUN apk update \
    && apk add git \
    && apk add make \
    && apk add zip \
    && go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.50.1 \
    && go install github.com/go-swagger/go-swagger/cmd/swagger@v0.30.3

EXPOSE 8080
