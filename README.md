# Go example project with Buildkite Pipeline

[![Go Reference](https://pkg.go.dev/badge/golang.org/x/example.svg)](https://pkg.go.dev/golang.org/x/example)
[![Build status](https://badge.buildkite.com/a3e36c0854c2c542520fffad6480ba523db5d028849c20b1ae.svg?branch=main)](https://buildkite.com/flying-llamas-ltd/buildkite-example?branch=main)

This repository is a fork of the basic Golang example repo, trimmed down to contain a single example.

It's a simple application that takes a command line argument, and then returns it to you in a string:

```
$ hello John Doe

Hello, John Doe!
```
It has basic [unit](hello/hello_test.go) and [integration](test.sh) tests, and a Buildkite Pipeline which builds and tests the command within a custom Docker container.

## Build the project

### Automatic build with Buildkite Pipeline

The pipeline is defined in the [.buildkite/pipeline.yaml](.buildkite/pipeline.yaml) file. To use it with a forked repository, ensure that your Buildkite Pipeline is configured to use [pipeline upload](https://buildkite.com/docs/pipelines/defining-steps#step-defaults-pipeline-dot-yml-file).

Notable files used by the pipeline:

* **[`docker/gotestsum/Dockerfile`](docker/gotestsum/Dockerfile)** : the Dockerfile for an image that includes the Golang tools and gotestsum test runner. The `pipeline.yaml` file is configured to pull this image from the Buildkite Package Registry.
* **[`.buildkite/hooks/post-command`](.buildkite/hooks/post-command)** : This post-command hook is run by the Buildkite agent during the unit test step. It sets `BUILDKITE_ANALYTICS_TOKEN` with a secret pulled from the Builkite secrets store. This variable is needed by the Test Collector plugin to submit test results to the Buildkite Test Engine.
* **[`test.sh`](test.sh)** : A basic shell script which tests the built command.

### Manual build

```
$ cd hello
$ go build
```

This will produce a compiled binary named `hello`.

To make the binary executable:

```
$ chmod +x ./hello
```

### Run the command

From the root of the repository:

```
$ ./hello/hello John Doe
```

The above will return 'Hello, John Doe!'
