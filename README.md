# CPUT Thesis LaTeX Template

This is a LaTeX template that closely matches the official Cape Peninsula University of Technology (CPUT) Thesis Template Word document. The template replicates the formatting, structure, and styling of the original Word template.

## Authors

- Boniface Kabaso
- Waldon Henricks

## Features

- **Faithful formatting**: Matches the supplied CPUT Word template closely:
  - Margins: 3cm left, 2cm right/top/bottom
  - Font: Arial when compiling with XeLaTeX/LuaLaTeX; Helvetica-compatible fallback with PDFLaTeX
  - Line spacing: 1.5 for text, single for tables and bibliography
  - Chapter headings: 12-point bold, centered
  - Section headings: 11-point bold
  - Decimal numbering for sections (1.1, 1.1.1, etc.)
  - No colored placeholder text, link boxes, or visible hyperlink markings
- **Complete structure**: Includes all required sections:
  - Title page with CPUT logo
  - Declaration
  - Abstract
  - Acknowledgements
  - Dedication (optional)
  - Table of Contents
  - List of Figures
  - List of Tables
  - Glossary
  - Chapters
  - Bibliography/References
  - Appendices
- **Flexible**: Compatible with PDFLaTeX, XeLaTeX, and LuaLaTeX

## Files

- `cputthesis.cls` - Document class defining all formatting
- `cput-thesis.tex` - Main document file (edit this)
- `chapter1.tex`, `chapter2.tex`, `chapter3.tex` - Example chapter files
- `appendixA.tex`, `appendixB.tex` - Example appendix files
- `references.bib` - BibLaTeX bibliography database
- `compile.sh` - Portable build script for LaTeX and Biber
- `compile.bat` - Windows build script for LaTeX and Biber
- `.github/workflows/` - GitHub Actions workflows for PDF builds and release artifacts
- `CHANGELOG.md` - Version history
- `CONTRIBUTING.md` - Contribution workflow and pull request instructions
- `media/` - Directory containing CPUT logo and example images
- `AUTHORS.md` - Template authors
- `LICENSE` - Creative Commons license

## Quick Start

1. **Edit the main file**: Open `cput-thesis.tex` and update the thesis metadata:
   ```latex
   \thesistitle{Your Thesis Title}
   \authorfull{Your Full Name}
   \degreetype{Master of Technology/Doctor of Technology: Your Degree}
   \discipline{Your Discipline}
   \faculty{in the Faculty of Your Faculty}
   \supervisor{Supervisor: Name}
   \cosupervisor{Co-supervisor: Name or delete}
   \campus{Your Campus}
   \submissiondate{Month Year}
   ```

2. **Add your content**:
   - Edit `chapter1.tex`, `chapter2.tex`, `chapter3.tex`, or create new chapter files
   - Include chapters with `\include{filename}` (without `.tex` extension)
   - Add figures in `media/` directory and reference with `\includegraphics`
   - Add bibliography entries to `references.bib`
   - Add glossary terms in the `cputglossary` environment

3. **Compile**:
   ```bash
   ./compile.sh xelatex
   ```
   TeXstudio users can set the compiler to XeLaTeX and build `cput-thesis.tex`
   directly. PDFLaTeX is also supported:
   ```bash
   ./compile.sh pdflatex
   ```
   The script runs `biber` automatically for the Harvard-style bibliography and
   runs LaTeX enough times to update the table of contents, list of figures, and
   list of tables.

## Windows Setup and Recommendations

Most Windows users should use MiKTeX or TeX Live with TeXstudio.

Recommended setup:

- Install the latest MiKTeX or TeX Live for Windows.
- Install TeXstudio.
- Open `cput-thesis.tex` as the main file.
- Use XeLaTeX as the default compiler. This gives the closest match to the Word template because Windows normally includes Arial.
- Use Biber, not BibTeX, for the bibliography.
- Keep the project in a simple local folder such as `C:\Thesis\cput-thesis-template`. Avoid synced or deeply nested folders while compiling, especially OneDrive folders, because PDF and auxiliary file locks can interrupt builds.
- If MiKTeX asks to install missing packages, allow it to do so, then rerun the build.
- Use TeXstudio's internal PDF viewer or close the PDF before rebuilding. Some external PDF viewers lock the PDF and prevent LaTeX from overwriting it.

Command Prompt or PowerShell users can build with:

```bat
compile.bat xelatex
```

PDFLaTeX is also available:

```bat
compile.bat pdflatex
```

If you prefer to run the commands manually, use this sequence:

```bat
xelatex -interaction=nonstopmode -halt-on-error cput-thesis.tex
biber cput-thesis
xelatex -interaction=nonstopmode -halt-on-error cput-thesis.tex
xelatex -interaction=nonstopmode -halt-on-error cput-thesis.tex
```

In TeXstudio, check these settings under **Options > Configure TeXstudio > Build**:

- Default Compiler: `XeLaTeX`
- Default Bibliography Tool: `Biber`
- Main document: `cput-thesis.tex`

If citations show as question marks, run the bibliography tool once and then compile twice more.

## GitHub Release Workflow

This repository includes GitHub Actions workflows for validating the PDF build and publishing versioned template downloads.

- `Build template PDF` runs on pushes, pull requests, and manual dispatch. It compiles `cput-thesis.tex` with XeLaTeX and uploads a short-lived preview artifact.
- `Publish release artifact` is manual. Run it from the GitHub **Actions** tab when you are ready to publish a version.

To publish version `1.0.0`:

1. Go to **Actions > Publish release artifact > Run workflow**.
2. Set `version` to `1.0.0`.
3. Leave `engine` as `xelatex` unless you specifically want PDFLaTeX or LuaLaTeX.
4. Leave `publish_release` enabled to create or update the GitHub Release `v1.0.0`.
5. Download the versioned template archive from the workflow artifact or from the GitHub Release assets.

The manual workflow publishes these versioned downloads:

- `cput-thesis-template-<version>.zip` - recommended for Windows users.
- `cput-thesis-template-<version>.tar.gz` - useful for Linux/macOS users.
- `cput-thesis-template-<version>-preview.pdf` - compiled preview PDF.

Each archive contains a ready-to-use folder with the LaTeX source files, bibliography file, media assets, build scripts, README, changelog, authors file, and license. The workflow uses `CHANGELOG.md` for release notes.

## Detailed Usage

### Chapter Structure
Each chapter should be in a separate `.tex` file for better organization. Use the provided `chapter1.tex` as a template. The chapter structure uses standard LaTeX sectioning commands:

```latex
\chapter{Chapter Title}
\section{Section Heading}
\subsection{Subsection Heading}
\subsubsection{Sub-subsection Heading}
```

### Figures and Tables
- Figures: Use `\begin{figure}...\end{figure}` with `\caption` below the figure
- Tables: Use `\begin{table}...\end{table}` with `\caption` above the table
- Follow CPUT formatting: single spacing for captions, appropriate justification

### Table of Contents and Lists

The sample document uses `\cputcontents`, which generates the table of contents, list of figures, and list of tables from the actual document structure. Do not edit these pages manually. The generated table of contents keeps the Word-template style: chapter headings appear as standalone lines such as `CHAPTER ONE: TITLE`, and section entries use dotted leaders with right-aligned page numbers.

After adding, removing, or renaming chapters, sections, figures, tables, bibliography entries, or appendices, run the compile script again:

```bash
./compile.sh xelatex
```

On Windows:

```bat
compile.bat xelatex
```

If you compile manually in an editor, run LaTeX, then Biber, then LaTeX twice more so the generated pages and page numbers settle.

### Bibliography
The template uses BibLaTeX with a Harvard-style author-year format. Add sources to `references.bib`, cite them in the text with `\textcite{key}` or `\parencite{key}`, and print the bibliography with `\printcputbibliography`.

Examples:
```latex
\textcite{van-aswegen-2006}
\parencite[33--37]{van-aswegen-2006}
```

### Glossary
Edit the `cputglossary` environment to add terms, acronyms, and abbreviations.

## Customization

### Page Numbering
The template currently uses continuous Arabic numbering. If you need chapter-page numbering (e.g., 3-1, 3-2), add this to your preamble:

```latex
\usepackage{chngcntr}
\counterwithin{page}{chapter}
\renewcommand{\thepage}{\thechapter-\arabic{page}}
```

### Front Matter Page Numbers
To use Roman numerals for front matter (Declaration, Abstract, etc.), wrap the front matter with `\frontmatter` and `\mainmatter`. This requires modifying the class file.

## Requirements

- A LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Biber for the BibLaTeX Harvard-style references
- Basic LaTeX knowledge

## Notes

- Compile with XeLaTeX for the closest match to the Word template because it can use Arial directly.
- The sample document uses `\cputcontents` for generated contents and lists. The older `\cputmanualcontents` command remains as a compatibility alias, but it now generates dynamic contents too.

## Support

This template is provided as-is. For CPUT-specific requirements, consult your supervisor and the official CPUT thesis guidelines.

## Contributing

Contributions should be made through pull requests to https://github.com/boniface/cput-thesis-template. Fork the repository, clone it with `git clone`, create a feature branch, make the change, compile the template, push the branch, and open a PR. See `CONTRIBUTING.md` for the full command-line workflow.

## License

This template is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0). See `LICENSE`.

---

*Based on CPUT Thesis Template Word document, converted to LaTeX with attention to detail.*
