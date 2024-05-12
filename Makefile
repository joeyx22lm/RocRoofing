SHELL := /bin/bash
PWD = $(shell pwd)
BUILD_CONTEXT_DOCKER_IMAGE = "rocroofing-builder-ctx"

shell:
	@source makescript.sh; shell "$(PWD)" "$(BUILD_CONTEXT_DOCKER_IMAGE)"

clean:
	@source makescript.sh; clean "$(PWD)" "$(BUILD_CONTEXT_DOCKER_IMAGE)"

start:
	@source makescript.sh; run_command "$(PWD)" "$(BUILD_CONTEXT_DOCKER_IMAGE)" "cd /src/frontend && npm install && npm run dev"

build:
	@source makescript.sh; run_command "$(PWD)" "$(BUILD_CONTEXT_DOCKER_IMAGE)" "cd /src/frontend && npm install && npm ci && npm run build"

.PHONY: build