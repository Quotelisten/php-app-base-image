.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ##Retrieve an authentication token and authenticate your Docker client to your registry.
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 991561267216.dkr.ecr.us-east-1.amazonaws.com
build-push: ##Retrieve an authentication token and authenticate your Docker client to
	make build
	make push
	
build: ## Build your Docker image using the following command. For information on building a Docker file from scratch
	docker build -t php-api-base-image-ecr .

push: ## After the build is completed, tag your image so you can push the image to this repository:
	docker tag php-api-base-image-ecr:latest 991561267216.dkr.ecr.us-east-1.amazonaws.com/php-api-base-image-ecr:latest
	docker push 991561267216.dkr.ecr.us-east-1.amazonaws.com/php-api-base-image-ecr:latest