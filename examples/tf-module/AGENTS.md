# AGENTS.md

This repository contains a Terraform module project following a unified
standard for tooling, build automation, and coding conventions. All projects
share the same conventions to keep modules consistent and maintainable.

The key components of the standard include:

- Build automation (TFMake)
- Infrastructure validation (`terraform validate`, TFLint)
- Security scanning (Trivy)
- Documentation generation (terraform-docs)

This document outlines the common conventions that apply across the Terraform
module projects.

## Runtime & Dependencies

- **Terraform**: version pinned via `.terraform.lock.hcl`
- **Linting**: TFLint (`.tflint.hcl`)
- **Security Scanning**: Trivy
- **Documentation Generation**: terraform-docs
- **Configuration Tooling**: yq

### Adding Dependencies

```bash
# Add or update a required_providers/module block in main.tf or variables.tf
make init    # Reinitialize Terraform and refresh .terraform.lock.hcl
make deps    # Install TFLint, terraform-docs, and Trivy
```

## Project Structure

```text
project/
├── examples/                # Example module usages (.tf)
├── .github/                 # GitHub workflows
├── .tflint.hcl              # TFLint configuration
├── main.tf                  # Module resource definitions
├── Makefile                 # Build automation (TFMake)
├── outputs.tf                # Module outputs
├── README.md                  # Project README (includes generated Terraform Doc section)
└── variables.tf                # Module input variables
```

Build configuration (package name, author) is read from a `tfmake.yml` file via
`yq`, following [TFMake's configuration convention](https://github.com/cliffano/tfmake#configuration).

## Build Automation (TFMake)

This project uses **TFMake** as its standard build automation tool for
Terraform module projects.

### Common Commands

```bash
make ci                 # Run clean + stage + deps + init + style + lint + doc
make all                # Alias for ci
make clean              # Remove local Terraform state (.terraform/)
make stage               # Ensure stage/ directory exists
make deps                # Install TFLint, terraform-docs, and Trivy
make init                 # Reinitialize Terraform and refresh the lock file
make style                # Format Terraform files (terraform fmt -recursive)
make lint                 # Run terraform validate, TFLint, and Trivy config scan
make doc                  # Regenerate the README.md Terraform Doc section
```

## Development Environment

This project is designed to be developed in a consistent environment via Docker
image `cliffano/studio`.

You can run the container using: `docker run --rm --workdir /opt/workspace -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/opt/workspace -i -t cliffano/studio` and then run the build commands inside the container.

## Code Style and Linting

- Terraform files are validated via `make lint`
- Terraform files should stay formatted via `make style` before committing
- Workflow and config changes should stay deterministic and minimal

### Terraform Module Code Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`, `*.tf`, `examples/**/*.tf`, `.tflint.hcl`, `README.md`, `CHANGELOG.md`

#### Style & Formatting

##### Workflow and Build Config

All workflow and build configuration changes should stay explicit, readable, and
reproducible.

Guidelines:

- Use two-space indentation in YAML files
- Keep workflow/job/step names descriptive
- Avoid compact one-liners that hide intent in CI definitions
- Keep shell snippets readable and fail fast

##### Terraform Files

Terraform files should stay valid and consistently formatted:

```bash
make style
make lint
```

Guidelines:

- Keep resource, variable, and output names descriptive and consistent
- Prefer explicit variable types and descriptions over implicit ones
- Keep `examples/` usages minimal and focused on one scenario each

#### Module Structure Conventions

- Keep resource definitions in `main.tf`
- Keep input variables in `variables.tf`
- Keep module outputs in `outputs.tf`
- Keep the README's generated "Terraform Doc" section in sync via `make doc`

#### Validation

- Treat lint and security scan failures as build failures
- Run `make lint` before merging Terraform changes
- Run `make doc` after changing variables/outputs and commit the regenerated README section

## Testing

- This project emphasizes deterministic validation via `terraform validate`, TFLint, and Trivy rather than a dedicated unit test suite
- Run validation with `make ci`

### Testing Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`

#### Validation Strategy

This project currently relies on deterministic validation via Terraform's own
validation tooling rather than dedicated unit test suites.

Primary validation commands:

```bash
make ci
make lint
```

#### What to Validate

- Terraform configuration validity (`terraform validate`)
- Linting rules compliance (TFLint)
- Security/misconfiguration scan results (Trivy)
- Generated documentation stays in sync (`make doc`)

#### Workflow Test Practices

- Keep CI steps deterministic and idempotent
- Avoid network-dependent checks unless required by tool installation (`make deps`)
- Fail fast on missing configuration values

#### Regression Prevention

When changing module resources, variables, or outputs:

1. Run `make style`
2. Run `make lint`
3. Run `make doc` and verify the README's Terraform Doc section
4. Verify `examples/` usages still reflect the current variable/output shape
