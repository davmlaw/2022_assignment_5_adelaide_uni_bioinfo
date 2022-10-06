#!/bin/bash

# This prints a CSV to standard out, redirect to create a file

FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
REPO_DIR=$(dirname $(dirname ${FULL_PATH_TO_SCRIPT}))

DATA_DIR=${REPO_DIR}/data
ORIGINAL_DATA_DIR=${REPO_DIR}/original_data
BRANCH=$(git rev-parse --abbrev-ref HEAD)
# BRANCH=stable  # Testing only!

echo "branch,filename,grade,files_match,case_insensitive_match,x_strip_match"

for data_filename in ${DATA_DIR}/BIOINF*;
do
    BASENAME=$(basename ${data_filename})
    original_data_filename=${ORIGINAL_DATA_DIR}/${BASENAME}
    diff ${original_data_filename} ${data_filename} > /dev/null
    exit_status=$?
    files_match="N" && [[ $exit_status == 0 ]] && files_match="Y"
    cat ${data_filename} | tr '[:upper:]' '[:lower:]' | diff ${original_data_filename} - > /dev/null
    exit_status=$?
    case_insensitive_match="N" && [[ $exit_status == 0 ]] && case_insensitive_match="Y"
    cat ${data_filename} | sed 's/XXXXXXX //g' | diff ${original_data_filename} - > /dev/null
    exit_status=$?
    x_strip_match="N" && [[ $exit_status == 0 ]] && x_strip_match="Y"
    GRADE="fail"
    if [ ${BRANCH} == "main" ]; then
        # In main - everything should be fixed
        if [ ${files_match} == "Y" ]; then
            GRADE="pass"
        fi
    elif [ ${BRANCH} == "stable" ]; then
        # In stable - only the XXX should be fixed (so case insensitive is left)
        if [[ (${files_match} == "N") && (${case_insensitive_match} == "Y") ]]; then
            GRADE="pass"
        fi
    fi

    echo "${BRANCH},${BASENAME},${GRADE},${files_match},${case_insensitive_match},${x_strip_match}"
done
