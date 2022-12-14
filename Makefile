.PHONY: deps
deps:
	go mod download
	go mod tidy

.PHONY: build
build:deps
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-s -w" -trimpath -o bin/lambda cmd/todo-list-server/main.go

run:
	go run cmd/todo-list-server/main.go

.PHONY: test
test:
	export DYNAMO_TABLE_USERS=local_users;\
	go test -race -v -count=1 ./

.PHONY: generate-server
generate-server:
	rm -rf ./models ./restapi/operations
	swagger generate server --exclude-main -f ./swagger.yaml

.PHONY: zip
zip: build
	zip -j bin/lambda.zip bin/lambda

# .PHONY: deploy
# deploy: zip
# 	aws lambda update-function-code --region ap-northeast-1 --function-name example-api --zip-file fileb://bin/lambda.zip