# GitHub Automation

This repository publishes the built explorer to GitHub Pages and can automatically merge approved pull requests.

## GitHub Pages

In repository settings:

1. Go to **Settings > Pages**.
2. Set **Build and deployment > Source** to **GitHub Actions**.
3. If `ping.pub` should keep using the custom domain, configure the domain in the same page.

The `Deploy to GitHub Pages` workflow builds the `explorer` submodule, copies this repository's chain configs and logos into the build output, uploads `explorer/dist`, and deploys it through GitHub Pages.

The workflow also copies `index.html` to `404.html`. GitHub Pages serves `404.html` for missing paths, so direct visits to Vue Router history-mode URLs can fall back to the SPA entry and be handled client-side. This approximates an nginx `try_files $uri /index.html` setup, although the HTTP status for those fallback responses is still 404 because GitHub Pages is static hosting.

## Pull Request Review

The `Pull Request Review` workflow runs on pull requests that change chain configs, logos, workflows, or repository metadata. It validates chain configs and verifies that the explorer still builds.

Pull requests also use `.github/pull_request_template.md` so contributors provide the same manual test checklist requested in the README.

## Auto Merge

Auto merge is intentionally gated:

- The pull request must have the `automerge` label.
- The pull request must have at least one approval.
- Required branch protection checks must pass.

Recommended branch protection for `main`:

- Require a pull request before merging.
- Require approvals.
- Require status checks to pass before merging.
- Add `Pull Request Review / Check blockchain configs` and `Pull Request Review / Build explorer` as required checks.
- Enable **Allow auto-merge** in **Settings > General**.

To auto merge a pull request, add the `automerge` label after the review requirements are satisfied. The workflow uses squash merge and deletes the source branch after merging.
