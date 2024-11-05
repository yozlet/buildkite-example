#!/bin/bash

set -euo pipefail

# Fetch the name argument to pass to the "hello" command.
TEST_NAME_ARG=$(buildkite-agent meta-data get test-name-arg)

# Download the "hello" command binary to the "build" folder
buildkite-agent artifact download hello/hello .

# Run the command with the name argument
chmod +x hello/hello

OUTPUT=$(./hello/hello $TEST_NAME_ARG)

if [[ $OUTPUT = "Hello, $TEST_NAME_ARG!" ]]
then
    echo $OUTPUT
else
    echo "INCORRECT OUTPUT: $OUTPUT"
    exit 1
fi
