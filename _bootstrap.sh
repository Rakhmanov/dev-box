#!/usr/bin/env bash
set -e

# This file must be included in all other shells to save time

# Path additions
[ -f "$HOME/.path_additions" ] && source "$HOME/.path_additions"

# Function to write single time to file
source ./scripts/static/add_once_to_file.sh
