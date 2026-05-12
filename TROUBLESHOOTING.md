# CPUT Thesis LaTeX Troubleshooting Guide

This guide helps you fix common compilation errors when using the CPUT LaTeX thesis template with XeLaTeX, Biber, and `biblatex`.

## Errors You Might See

| Error Message | Meaning |
|---------------|---------|
| `Citation 'van-aswegen-2006' undefined` | The bibliography entry exists in `.bib` but Biber hasn’t been run. |
| `File ended while scanning use of \include` | A closing brace `}` is missing in an `\include{...}` command. |
| `No file cput-thesis.bbl` | Biber has never created the bibliography file. |
| `Empty bibliography` | The `\printbibliography` command is present but the `.bbl` file is missing or empty. |

---

## Step 1: Fix the `\include` Error – Missing Closing Brace

This error stops LaTeX early and prevents Biber from running.

**Check your main `.tex` file** (e.g., `cput-thesis.tex`). Look for lines like:

```latex
\include{chapter3   % ← missing closing brace
