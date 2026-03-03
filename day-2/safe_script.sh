#!/bin/bash

set -e

mkdir -p /tmp/devops-test || { echo "Failed to create directory"; exit 1; }

cd /tmp/devops-test || { echo "Failed to navigate"; exit 1; }

touch test.txt || { echo "Failed to create file"; exit 1; }

echo "All steps completed successfully"