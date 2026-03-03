#!/bin/bash

# Enable strict mode
set -euo pipefail

echo "Strict mode enabled"

#  Using undefined variable (set -u demo)
echo "Value of name is: $name"

# Command failure demo (set -e demo)
mkdir /root/test-folder

#  Pipe failure demo (set -o pipefail demo)
cat missingfile.txt | grep "hello"

echo "Script completed"