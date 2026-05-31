#!/usr/bin/env bash

set -euo pipefail

INPUT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$HOME/.claude"

# Make sure the target folders exist
mkdir -p "$OUTPUT/data" "$OUTPUT/scripts"

# Copy the two config files
cp "$INPUT/settings.json" "$OUTPUT/settings.json"
cp "$INPUT/CLAUDE.md" "$OUTPUT/CLAUDE.md"

# Copy the folder contents
cp -R "$INPUT/data/." "$OUTPUT/data/"
cp -R "$INPUT/scripts/." "$OUTPUT/scripts/"

echo "Deployed Claude Code settings to $OUTPUT"
