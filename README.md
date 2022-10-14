# Assignment 5 - University-of-Adelaide-Bx-Masters / BIOTECH-7005-BIOINF-3000

## Branches

This repository has 2 branches:

* **main** - the default branch, where new development occurs. All changes go into here
* **stable** - a locked down branch for a critical system, the only updates are high severity bug fixes

## Data files

The "data" and "doc" directories contains 35 files each:

```
BIOINF_3000_2022-1
BIOINF_3000_2022-2
BIOINF_3000_2022-3
....
BIOINF_3000_2022-34
BIOINF_3000_2022-35
```

These correspond to the name of the Virtual Machine you were assigned at the start of the course.

If you're on your VM, you can get this by typing "hostname" on the command prompt

You should ONLY work on the files assigned to you.

## Simulated errors

These files have had simulated errors created them, there are two types:

| Insertion                          | Severity |
|------------------------------------|----------|
| XXXXXXX                            | High     |
 | lower_case_word -> UPPER_CASE_WORD | Low |

There are a maximum of 3 types of each error in each file.

## Testing / Marking

There's a script (./bin/detect_differences.sh) that we'll use to check whether the files match what we expect.

Feel free to use it to check your work. Run the diff lines against your files (removing the redirect to /dev/null) to see what needs to change
