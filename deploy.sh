#!/usr/bin/env bash

set -euo pipefail

INPUT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$HOME/.claude"

# Make sure the target folders exist
mkdir -p "$OUTPUT/data" "$OUTPUT/scripts"

# CLAUDE.md: safe to overwrite outright
cp "$INPUT/CLAUDE.md" "$OUTPUT/CLAUDE.md"

# settings.json: deep-merge into the existing file so locally-added keys (extra
# enabledPlugins, marketplaces, etc.) survive. jq's "*" recursively merges
# objects with the right operand winning, so the repo's values take precedence.
if [ -f "$OUTPUT/settings.json" ]; then
    tmp="$(mktemp)"
    jq -s '.[0] * .[1]' "$OUTPUT/settings.json" "$INPUT/settings.json" > "$tmp"
    mv "$tmp" "$OUTPUT/settings.json"
else
    cp "$INPUT/settings.json" "$OUTPUT/settings.json"
fi

# Copy the folder contents
cp -R "$INPUT/data/." "$OUTPUT/data/"
cp -R "$INPUT/scripts/." "$OUTPUT/scripts/"

echo "Deployed Claude Code settings to $OUTPUT"
