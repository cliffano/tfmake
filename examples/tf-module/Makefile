################################################################
# TFMake: Makefile for building Terraform modules
# https://github.com/cliffano/tfmake
################################################################

# TFMake's version number
TFMAKE_VERSION = 1.1.1-pre.0

################################################################
# User configuration variables
# These variables should be stored in tfmake.yml config file,
# and they will be parsed using yq https://github.com/mikefarah/yq
# Example:
# ---
# package_name: somepackage
# author: Some Author

# PACKAGE_NAME is the name of the Terraform module
PACKAGE_NAME=$(shell yq .package_name tfmake.yml)

# AUTHOR is the author of the node.js package
AUTHOR ?= $(shell yq .author tfmake.yml)

$(info ################################################################)
$(info Building Terraform module using TFMake with user configurations...)
$(info - Package name = ${PACKAGE_NAME})
$(info - Author = ${AUTHOR})

################################################################
# Base targets

# CI target to be executed by CI/CD tool
all:ci
ci: clean stage deps init style lint doc

clean:
	rm -rf .terraform

stage:
	mkdir -p stage/

deps: stage
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
	curl -sSLo stage/terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-`uname`-amd64.tar.gz
	cd stage/ && tar -xzf terraform-docs.tar.gz --no-same-owner && chmod +x terraform-docs
	curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b stage

init:
	rm -f .terraform.lock.hcl
	terraform init

style:
	terraform fmt -recursive

lint: init
	terraform validate
	tflint --chdir=.
	stage/trivy config --exit-code 1 .

doc:
	sed -zi 's/# Terraform Doc.*/# Terraform Doc/' README.md
	stage/terraform-docs markdown . > stage/terraform-docs-output.md
	sed -i '/# Terraform Doc/r stage/terraform-docs-output.md' README.md

# Update Makefile to the latest version tag
update-to-latest: TARGET_TFMAKE_VERSION = $(shell curl -s https://api.github.com/repos/cliffano/tfmake/tags | jq -r '.[0].name')
update-to-latest: update-to-version

# Update Makefile to the main branch
update-to-main:
	curl https://raw.githubusercontent.com/cliffano/tfmake/main/src/Makefile-tfmake -o Makefile

# Update Makefile to the version defined in TARGET_TFMAKE_VERSION parameter
update-to-version:
	curl https://raw.githubusercontent.com/cliffano/tfmake/$(TARGET_TFMAKE_VERSION)/src/Makefile-tfmake -o Makefile

.PHONY: clean stage deps init style lint doc update-to-latest update-to-main update-to-version
