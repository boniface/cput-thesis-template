#!/usr/bin/env bash
# Compilation script for CPUT Thesis Template

set -euo pipefail

MAIN_FILE="${MAIN_FILE:-cput-thesis.tex}"
COMPILER="${1:-xelatex}"

case "$COMPILER" in
  pdflatex|xelatex|lualatex) ;;
  *)
    echo "Usage: ./compile.sh [pdflatex|xelatex|lualatex]"
    exit 2
    ;;
esac

echo "Compiling $MAIN_FILE using $COMPILER..."

"$COMPILER" -interaction=nonstopmode -halt-on-error "$MAIN_FILE"
if [ -f "${MAIN_FILE%.tex}.bcf" ]; then
    biber "${MAIN_FILE%.tex}"
fi
"$COMPILER" -interaction=nonstopmode -halt-on-error "$MAIN_FILE"
"$COMPILER" -interaction=nonstopmode -halt-on-error "$MAIN_FILE"

echo "Compilation complete."
