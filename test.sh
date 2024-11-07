#!/bin/bash

set -euo pipefail

# Fetch the name argument to pass to the "hello" command.
TEST_NAME_ARG=$(buildkite-agent meta-data get test-name-arg)

# Download the "hello" command binary to the "build" folder
buildkite-agent artifact download hello/hello .

# make the command executable
chmod +x hello/hello

# Run the command with the name argument
OUTPUT=$(./hello/hello $TEST_NAME_ARG)

# Test the command output and exit with an error if it doesn't match
if [[ $OUTPUT = "Hello, $TEST_NAME_ARG!" ]]
then
    echo $OUTPUT
else
    echo "INCORRECT OUTPUT: $OUTPUT"
    exit 1
fi
