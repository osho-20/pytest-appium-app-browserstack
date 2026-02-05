#!/bin/bash
set -e  # Exit on error

echo "starting pytest testing"

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: $SCRIPT_DIR"
cd "$SCRIPT_DIR"

echo "creating virtual environment and installing dependencies"
python -V
python -m venv env

if [ ! -f "env/bin/activate" ]; then
    echo "ERROR: Failed to create virtual environment"
    exit 1
fi

source env/bin/activate
echo "virtual environment created and activated"

echo "installing dependencies from requirements.txt"
if [ ! -f "requirements.txt" ]; then
    echo "ERROR: requirements.txt not found"
    exit 1
fi

pip install -r requirements.txt
echo "dependencies installed"

if [ ! -d "android" ]; then
    echo "ERROR: android directory not found"
    exit 1
fi

cd android
echo "running pytest for bstack-sample-test.py"
rm -rf log logs
browserstack-sdk pytest ./bstack_sample.py -s
TEST_EXIT_CODE=$?

echo "pytest testing completed with exit code: $TEST_EXIT_CODE"

cd "$SCRIPT_DIR"
deactivate

exit $TEST_EXIT_CODE
