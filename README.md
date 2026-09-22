<img align="right" src="https://raw.github.com/cliffano/tfmake/master/avatar.jpg" alt="Avatar"/>

[![Build Status](https://github.com/cliffano/tfmake/actions/workflows/ci-workflow.yaml/badge.svg)](https://github.com/cliffano/tfmake/actions/workflows/ci-workflow.yaml)
<br/>

Knut Haugland
-------------

Knut Haugland is a Makefile for creating Kon-Tiki static web sites.
It provides utility targets for building, deploying, and managing the infrastructure of the static web sites.

Have a look at [examples/](examples/) for example projects of how Knut Haugland can be used.

![Screenshot of example static-content web site](/screenshots/example-static-content.png "Example static-content web site")

![Screenshot of example static-redirect web site](/screenshots/example-static-redirect.png "Example static-redirect web site")

Installation
------------

1. Download `src/Makefile-tfmake` as the `Makefile` of your project:
```text
`curl https://raw.githubusercontent.com/cliffano/tfmake/main/src/Makefile-tfmake -o Makefile`
```
2. Create configuration file `tfmake.yml` with properties described in [Configuration](#configuration) section
3. Run the available `Makefile` targets described in [Usage](#usage) section

Configuration
-------------

Create KnutHaugland configuration file called `tfmake.yml` with contains the following properties:

| Property | Description | Example |
|----------|-------------|---------|
| aws_region | [AWS region code](https://www.aws-services.info/regions.html) | `ap-southeast-2` |
| bucket_name | [S3 bucket name for the static web site](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html) | `knuthauglandexample.example.com` |

Usage
-----

The following targets are available:

| Target | Description |
|--------|-------------|
| ci | CI target to be executed by CI/CD tool, end to end build of the static web site |
| stage | Ensure stage directory exists |
| clean | Remove all temporary (staged, generated, cached) files |
| deps | Retrieve package dependencies using [Bob](https://github.com/cliffano/bob/) |
| update-to-latest | Update Makefile to the latest version on origin's main branch |
| update-to-version | Update Makefile to the version defined in `TARGET_TFMAKE_VERSION` parameter |
| build | Build the static web site using [AE86](https://github.com/cliffano/ae86/) |
| deploy | Sends the built static web site code to AWS S3 bucket |
| publish | A convenient target for running: clean deps init build deploy |
| infra-<init|destroy|refresh|plan|apply|import> | Targets for managing the infrastructure built using [Terraform AWS Kon-Tiki](https://github.com/cliffano/terraform-aws-kon-tiki/) |


Colophon
--------

Related Projects:

* [generator-kon-tiki](https://github.com/cliffano/generator-kon-tiki) - Kon-Tiki static web site projects generator using Plop
