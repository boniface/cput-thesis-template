# Changelog

All notable changes to this template will be documented in this file.

The format follows Keep a Changelog-style sections, and this project uses Semantic Versioning.

## [Unreleased]

## [1.0.2] - 2026-05-17

### Changed

- Replaced the default static table of contents/list pages with generated contents, list of figures, and list of tables while preserving the Word-template chapter-heading layout.
- Added generated table-of-contents entries for front-matter pages such as Declaration, Abstract, Acknowledgements, Dedication, and Glossary.

### Fixed

- Made Harvard in-text citations blue clickable PDF links that jump to the matching bibliography entry.

## [1.0.0] - 2026-05-10

### Added

- Initial CPUT thesis/dissertation LaTeX template release.
- CPUT-style cover page, declaration, abstract, acknowledgements, dedication, glossary, chapters, bibliography, and appendices.
- Harvard-style author-year references using BibLaTeX and Biber.
- Sample chapter content, table, figure, and reinforcement learning methodology chapter with mathematical equations.
- Cross-platform build scripts for macOS/Linux (`compile.sh`) and Windows (`compile.bat`).
- Windows setup and TeXstudio recommendations in the README.
- Creative Commons Attribution 4.0 International license.
- GitHub Actions workflows for CI PDF builds and manual versioned ZIP/TAR.GZ release artifact publishing.
