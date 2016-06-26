# Starter Project for github-sync-labels-milestones

This is a project to quickly get started using Jimdo/github-sync-labels-milestones for syncing milestones and labels across Github repos, especially using CI.

The intended workflow is:

1. Update `config.yml` with new milestones and labels
1. Commit and push to a git repo (preferably via pull request)
1. CI sync labels and milestones across target Github repos

For more info on github-sync-labels-milestones see <https://github.com/Jimdo/github-sync-labels-milestones>

## Usage

### Prerequisites

- Set `GITHUB_TOKEN` env var to Github personal access token
- Install node/npm
- Install Ruby and bundler (<http://bundler.io/>)
- Clone this repo and delete `.git` directory

### Configuration

For additional details on using gslm, see <https://github.com/Jimdo/github-sync-labels-milestones>

#### Target Repos

In `config.yml` place target repo slugs in a list under `repositories`

#### Labels and Milestones

`config.yml` has example labels and milestones.  Follow the examples and gslm docs to create your desired config.

#### (optional) git user for CI

In `do-release.sh` uncomment the lines that configure the git user settings and replace the name and email with your or your CI account's settings.

### Syncing

#### Running locally

To ensure your yaml is valid, first run

```bash
npm run lint
```

If you just want to perform syncs locally, just run

```bash
npm run sync
```

This command will read `config.yml` and sync the labels and milestones to the target repos.

#### Running via CI

Syncing and versioning your configs are easiest when done via CI.  Setting this up is quick and painless:

1. Create a git repo for your config and populate it with this starter project
1. Ensure that the `GITHUB_TOKEN` env var is set to your Github personal access token in CI
1. (optional) Ensure that CI has write access to your git repo
1. Configure the CI test command to be `npm run lint`
1. Configure the CI deployment command to be `npm run sync`
1. (optional) After `npm run sync` run `npm run release`
    - This will create and push a git tag, allowing you to later revert changes

`circle.yml` will make sync and release work out of the box using CircleCI (<https://circleci.com/>).  PRs welcome for configs for other CI services.
