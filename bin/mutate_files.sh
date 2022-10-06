#!/bin/bash

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
    FAKE_MESSAGE="Don't blame me, blame ${FAKE_NAME}"
    python3 ${BASE_DIR}/mutate.py ${filename}
    git add ${filename}
    git commit -m ${FAKE_MESSAGE}
    echo "${filename} - ${FAKE_MESSAGE}" >> ${ANSWERS_FILE}
done
