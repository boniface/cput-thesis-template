# Contributing

Contributions are welcome through pull requests to:

https://github.com/boniface/cput-thesis-template

Please keep changes focused, test the template locally, and avoid committing generated LaTeX build files such as `.aux`, `.log`, `.bcf`, `.bbl`, `.out`, `.synctex.gz`, and generated PDFs.

## Recommended Workflow

For most contributors, fork the repository on GitHub first, then clone your fork:

```bash
git clone git@github.com:YOUR-GITHUB-USERNAME/cput-thesis-template.git
cd cput-thesis-template
git remote add upstream git@github.com:boniface/cput-thesis-template.git
git checkout -b feature/short-description
```

Make your changes, then compile the template:

```bash
./compile.sh xelatex
```

On Windows, use:

```bat
compile.bat xelatex
```

Check what changed:

```bash
git status
git diff
```

Stage and commit only the relevant source files:

```bash
git add README.md cputthesis.cls cput-thesis.tex chapter3.tex
git commit -m "Describe the template improvement"
```

Push your branch:

```bash
git push -u origin feature/short-description
```

Then open your fork on GitHub and create a pull request from:

```text
YOUR-GITHUB-USERNAME:feature/short-description
```

into:

```text
boniface:main
```

If you use the GitHub CLI, you can create the pull request from the command line:

```bash
gh pr create \
  --repo boniface/cput-thesis-template \
  --base main \
  --title "Describe the template improvement" \
  --body "Summary of the change and how it was tested."
```

If you are a collaborator with direct write access, clone the main repository and push your feature branch:

```bash
git clone git@github.com:boniface/cput-thesis-template.git
cd cput-thesis-template
git checkout -b feature/short-description
```

Then follow the same edit, test, commit, push, and pull-request steps.

## Pull Request Checklist

- The change is focused and directly related to the template.
- The template compiles with `./compile.sh xelatex` or `compile.bat xelatex`.
- BibLaTeX/Biber references still compile when citations or `references.bib` are changed.
- Generated build artifacts are not committed.
- `README.md` is updated when usage instructions change.
- `CHANGELOG.md` is updated for user-facing changes.

## Release Notes

Maintainers publish versioned releases from the manual GitHub Actions workflow. Contributors should not attach generated release archives to pull requests.
