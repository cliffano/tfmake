# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Added
- Add s3_bucket_extras to output
- Add enable_s3_bucket_versioning config
- Add Lambda@Edge ARNs validation
- Add CloudFront price class config
- Add non-custom SSL certificate support
- Add trivy check to lint target

### Changed
- Switch version management from Makefile to variables.tf
- Bump up min Terraform to 1.14.0
- Replace deprecated OAI with OAC
- Replace deprecated aws_s3_bucket.website with custom error response

### Removed
- Remove s3 buckets force_destroy to avoid accidental deletion

### Fixed
- Fix deprecated module config with call_module_type

## 1.0.0 - 2024-11-09
### Added
- Add Makefile style target

### Changed
- Switch release workflow to use release-action
- Handle unarchiving of terraform-docs with non-owner
- Bump up min Terraform to 1.9.0

## 0.10.0 - 2024-01-24
### Added
- Initial version
