#!/usr/bin/env python3

from random import random
import sys

MAX_UPPERCASE = 3
MAX_XXX = 3
MUTATE_CHANCE = 0.15

def main():
    script_name = sys.argv[0]
    if len(sys.argv) != 2:
        raise ValueError(f"Usage: {script_name} text_file")

    filename = sys.argv[1]
    with open(filename) as f:
        original_lines = f.readlines()

    num_uppercase = 0
    num_xxx = 0
    with open(filename, "wt") as f:
        for line in original_lines:
            words = line.split(" ")
            if len(words) > 1 and random() < 0.5:  # Skip 50% of actual text lines
                new_words = []
                for word in words:
                    if num_uppercase < MAX_UPPERCASE:
                        if random() < MUTATE_CHANCE:
                            word = word.upper()
                            num_uppercase += 1

                    if num_xxx < MAX_XXX:
                        if random() < MUTATE_CHANCE:
                            new_words.append("XXXXXXX")
                            num_xxx += 1
                    new_words.append(word)
                line = " ".join(new_words)
            f.write(line)

    if num_uppercase < 1 or num_xxx < 1:
        raise ValueError(f"{filename} wasn't mutated properly!")  # Should never happen!


if __name__ == "__main__":
    main()