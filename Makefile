.PHONY: build check-target release-archive run

all: build

build: ## Build crcrcr
	shards build

check-target: ## Check that TARGET is present
ifndef TARGET
	$(error TARGET is undefined (make release-archive TARGET=linux))
endif

release-archive: check-target ## Make a tar.gz archive from the binary
	shards build --release ;\
	cd bin ;\
	tar czf crcrcr-$(TARGET).tar.gz crcrcr

check-version: ## Check that VERSION present
ifndef VERSION
	$(error VERSION is undefined (make push VERSION=42))
endif

push: check-version # Push to ALM
	git tag release-${VERSION}; \
	git push bitbucket master; \
	git push bitbucket master --tags; \
	git push codeberg master; \
	git push codeberg master --tags; \
	git push github master; \
	git push github master --tags

run: build ## Run crcrcr
	cd slides ;\
	crcrcr

run-fixed-width: build ## Run crcrcr with fixed width (400)
	cd slides ;\
	crcrcr -w 50 # Or crcrcr --width=50

help: ## Print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'