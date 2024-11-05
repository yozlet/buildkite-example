#!/bin/bash

# Fetch the name argument to pass to the "hello" command.
TEST_NAME_ARG=$(buildkite-agent meta-data get test-name-arg)

# Download the "hello" command binary to the "build" folder
buildkite-agent artifact download build/hello .

# Run the command with the name argument
chmod +x build/hello
./build/hello $TEST_NAME_ARG
