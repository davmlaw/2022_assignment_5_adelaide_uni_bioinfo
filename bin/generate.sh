#!/bin/bash

# This script requires 'faker': python -m pip install faker

# We want to generate individual data for each student, and use the number for the assigned VM (35)
NUM_STUDENTS=35
PREFIX=BIOINF_3000_2022-

for ((i=1;i<=NUM_STUDENTS;i++)); do
    faker paragraph -l en -r 10 | tr '[:upper:]' '[:lower:]' > "${PREFIX}${i}"
done

