#!/bin/zsh

# Wrote script 2022-09-14

echo "Building ~/logos.pdf from source file ~/logos.txt."

pandoc ~/logos.txt -f markdown -o ~/logos.pdf && open ~/logos.pdf

