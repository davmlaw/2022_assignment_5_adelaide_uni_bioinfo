#!/bin/bash

# Usage: mutate_files.sh BIOINFO* (make sure you don't include 'answers.txt')

set -e

FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
BASE_DIR=$(dirname ${FULL_PATH_TO_SCRIPT})

ANSWERS_FILE=answers.txt
if [ -e ${ANSWERS_FILE} ]; then
  rm ${ANSWERS_FILE}
fi

for filename in "$@"
do
    FAKE_NAME=$(faker name)
    python3 ${BASE_DIR}/mutate.py ${filename}
    git add ${filename}
    git commit -m "Don't blame me, blame ${FAKE_NAME}"
    GIT_COMMIT=$(git rev-parse HEAD)
    echo "${filename} - ${GIT_COMMIT} - ${FAKE_NAME}" >> ${ANSWERS_FILE}
done
