
DOCKERFILE := Dockerfile
PROJECT := ignition
ORIGIN := $(shell git remote get-url origin | sed -e 's/^.*@//g')
REVISION := $(shell git rev-parse --short HEAD)
DOCKERFILES := $(sort $(wildcard */$(DOCKERFILE)))
USERNAME := naokitakahashi12

# Directory identities
BUILD_ENV := buildenv
BLUEPRINT := blueprint
CITADEL := citadel

# Image type
BINALY := binaly
DEVEL := devel

# Support ubuntu distributions
BIONIC := bionic
FOCAL := focal

# Build image tag name
BINARY_BIONIC_CITADEL_TAG := $(CITADEL)-$(BIONIC)
BINARY_FOCAL_CITADEL_TAG := $(CITADEL)-$(FOCAL)
BINARY_BIONIC_BLUEPRINT_TAG := $(BLUEPRINT)-$(BIONIC)
DEVEL_BIONIC_CITADEL_TAG := $(CITADEL)-$(DEVEL)-$(BIONIC)
DEVEL_BIONIC_BLUEPRINT_TAG := $(BLUEPRINT)-$(DEVEL)-$(BIONIC)
DEVEL_BIONIC_BUILD_ENV_TAG := $(BUILD_ENV)-$(BIONIC)

define dockerbuild
	@docker build \
		--file $1 \
		--build-arg GIT_REVISION=$(REVISION) \
		--build-arg GIT_ORIGIN=$(ORIGIN) \
		--tag $2 \
	.
endef

.PHONY: all
all: help

.PHONY: build
build: \
	$(BINARY_BIONIC_CITADEL_TAG) \
	$(BINARY_FOCAL_CITADEL_TAG) \
	$(BINARY_BIONIC_BLUEPRINT_TAG) \
	$(DEVEL_BIONIC_CITADEL_TAG) \
	$(DEVEL_BIONIC_BLUEPRINT_TAG) \

$(BINARY_BIONIC_CITADEL_TAG): $(BINALY)/$(BIONIC)/$(CITADEL)/$(DOCKERFILE)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

$(BINARY_FOCAL_CITADEL_TAG): $(BINALY)/$(FOCAL)/$(CITADEL)/$(DOCKERFILE)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

$(BINARY_BIONIC_BLUEPRINT_TAG): $(BINALY)/$(BIONIC)/$(BLUEPRINT)/$(DOCKERFILE)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

$(DEVEL_BIONIC_CITADEL_TAG): $(DEVEL)/$(BIONIC)/$(CITADEL)/$(DOCKERFILE) $(DEVEL_BIONIC_BUILD_ENV_TAG)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

$(DEVEL_BIONIC_BLUEPRINT_TAG): $(DEVEL)/$(BIONIC)/$(BLUEPRINT)/$(DOCKERFILE) $(DEVEL_BIONIC_BUILD_ENV_TAG)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

$(DEVEL_BIONIC_BUILD_ENV_TAG): $(DEVEL)/$(BIONIC)/$(BUILD_ENV)/$(DOCKERFILE)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

.PHONY: clean
clean:
	@docker image rm $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_CITADEL_TAG)
	@docker image rm $(USERNAME)/$(PROJECT):$(BINARY_FOCAL_CITADEL_TAG)
	@docker image rm $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_BLUEPRINT_TAG)
	@docker image rm $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_CITADEL_TAG)
	@docker image rm $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_BLUEPRINT_TAG)
	@docker image rm $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_BUILD_ENV_TAG)

.PHONY: pull
pull:
	@docker pull $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_CITADEL_TAG)
	@docker pull $(USERNAME)/$(PROJECT):$(BINARY_FOCAL_CITADEL_TAG)
	@docker pull $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_BLUEPRINT_TAG)
	@docker pull $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_CITADEL_TAG)
	@docker pull $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_BLUEPRINT_TAG)
	@docker pull $(USERNAME)/$(PROJECT):$(DEVEL_BIONIC_BUILD_ENV_TAG)

.PHONY: help
help:
	@echo ""
	@echo " make <command> [option]"
	@echo ""
	@echo " Support commands"
	@echo " help  : print support commands"
	@echo " build : building docker images"
	@echo " clean : clean docker images"
	@echo " pull  : pulling docker images from registry"
	@echo ""
	@echo " Options"
	@echo " See the 'make --help'"
	@echo ""

