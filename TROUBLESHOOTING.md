# CPUT Thesis LaTeX Troubleshooting Guide

This guide helps resolve the most common compilation issues in the CPUT thesis template when using XeLaTeX, Biber, and `biblatex`.

---

# Step 1: Fix `\\include` Errors

## Error message

```text
File ended while scanning use of \\include
```

## Cause

A `\\include{...}` command is missing a closing brace `}`.

## How to fix

Open your main thesis file (for example `cput-thesis.tex`) and check every include statement.

Correct format:

```latex
\\include{chapter1}
\\include{chapter2}
\\include{chapter3}
```

Incorrect format:

```latex
\\include{chapter3
```

A missing brace often causes LaTeX to stop unexpectedly at the end of the document.

---

# Step 2: Verify Citation Keys in `references.bib`

## Error message

```text
Citation 'xyz' undefined
```

## Cause

The citation key used in the document does not exist in the bibliography file.

Example citation:

```latex
\\cite{van-aswegen-2006}
```

If the key does not exist in `references.bib`, compilation warnings will appear and the citation will display as `?`.

## How to fix

Open `references.bib` and verify the entry exists.

Example:

```bibtex
@book{van-aswegen-2006,
  author    = {Van Aswegen, L.},
  year      = {2006},
  title     = {Library research and the Harvard method},
  publisher = {CPUT}
}
```

Check carefully for:

* spelling differences
* uppercase/lowercase mismatches
* missing hyphens
* accidental spaces

---

# Step 3: Use the Correct Compilation Sequence

## Common error messages

```text
No file cput-thesis.bbl
```

```text
Empty bibliography
```

```text
Citation undefined
```

## Cause

The document was compiled with XeLaTeX only, without running Biber.

The CPUT template uses:

* `biblatex`
* `biber`
* `xelatex`

All three must work together.

---

## Manual Compilation (Terminal)

Run these commands inside the thesis folder:

```bash
xelatex cput-thesis
biber cput-thesis
xelatex cput-thesis
xelatex cput-thesis
```

## Why four commands?

| Step           | Purpose                                   |
| -------------- | ----------------------------------------- |
| First XeLaTeX  | Creates `.aux` and `.bcf` files           |
| Biber          | Generates the bibliography `.bbl` file    |
| Second XeLaTeX | Loads bibliography and resolves citations |
| Third XeLaTeX  | Fixes references, TOC, page numbers       |

---

# Step 4: Configure TeXstudio Correctly

If using TeXstudio, configure it to run Biber automatically.

## Steps

Open:

```text
Options → Configure TeXstudio → Build
```

Set:

```text
Default Compiler:
txs://xelatex | txs://biber
```

Then press:

```text
F5 → Build & View
```

TeXstudio will automatically run:

1. XeLaTeX
2. Biber
3. XeLaTeX
4. XeLaTeX

---

# Step 5: Clean Temporary Files

Sometimes old auxiliary files cause persistent compilation errors.

Delete temporary files before recompiling.

---

## Linux / macOS / Git Bash

```bash
rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc *.synctex.gz
```

---

## Windows Command Prompt

```cmd
del *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc *.synctex.gz
```

Then rerun the compilation sequence from Step 3.

---

# What Successful Compilation Looks Like

Your `.log` file should contain messages similar to:

```text
Package biblatex Info: ... file 'cput-thesis.bbl' found.
```

and:

```text
Output written on cput-thesis.pdf
```

There should be:

* no undefined citation warnings
* no emergency stop
* no missing bibliography errors

---

# Summary Table

| Problem                                      | Solution                              |
| -------------------------------------------- | ------------------------------------- |
| `File ended while scanning use of \\include` | Add missing `}` in `\\include{...}`   |
| `Citation '...' undefined`                   | Add or correct the bibliography entry |
| `No file .bbl` or empty bibliography         | Run `biber` after first XeLaTeX       |
| TeXstudio ignores Biber                      | Configure compiler correctly          |
| Persistent strange errors                    | Delete temporary files and rebuild    |

---

# Additional Checks

Ensure that:

* `references.bib` is in the same folder as `cput-thesis.tex`
* the bibliography filename matches exactly
* required packages are installed:

  * `xelatex`
  * `biblatex`
  * `biber`
  * `fontspec`

---

# Useful Official Resources

* TeXstudio Official Website: [https://www.texstudio.org/](https://www.texstudio.org/)
* Overleaf BibLaTeX Guide: [https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex)
* Biber Project Page: [https://sourceforge.net/projects/biblatex-biber/](https://sourceforge.net/projects/biblatex-biber/)
* XeLaTeX Documentation: [https://www.overleaf.com/learn/latex/XeLaTeX](https://www.overleaf.com/learn/latex/XeLaTeX)
