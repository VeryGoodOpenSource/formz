# 🦄 Contributing

First of all, thank you for taking the time to contribute! 🎉👍 Before you do, please carefully read this guide.

## Opening an issue

We highly recommend [creating an issue][bug_report_link] if you have found a bug, want to suggest a feature, or recommend a change. Please do not immediately open a pull request. Opening an issue first allows us to reach an agreement on a fix before you put significant effort into a pull request.

When reporting a bug, please use the built-in [Bug Report][bug_report_link] template and provide as much information as possible including detailed reproduction steps. Once one of the package maintainers has reviewed the issue and we reach an agreement on the fix, open a pull request.

## Developing

To develop for Formz you will need to become familiar with Very Good Ventures processes and conventions:

### Setting up your local development environment

1. Install a valid [Flutter SDK](https://docs.flutter.dev/get-started/install) in your local environment. Flutter SDK versions can be found in the [Flutter SDK archive](https://docs.flutter.dev/release/archive). Ensure it has a Dart version compatible with [Formz's Dart version constraint](https://github.com/VeryGoodOpenSource/formz/blob/main/pubspec.yaml).

1. Install Very Good CLI:

```sh
dart pub global activate very_good_cli
```

See [Very Good CLI installation](https://cli.vgv.dev/docs/overview#installing) for more information and troubleshooting if required. 

1. Install dependencies:

```sh
very_good packages get -r
```

1. Run tests (from the project root):

```sh
very_good test
```

If some tests do not pass out of the box, please submit an [issue](https://github.com/VeryGoodOpenSource/formz/issues/new/choose).


### Creating a Pull Request

1. [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects) the [GitHub repository](https://github.com/VeryGoodOpenSource/formz) and create your branch from `main`:

```sh
git checkout main
git pull
git checkout -b <branch-name>
```

Where `<branch-name>` is an appropriate name describing your change.

1. Implement your changes, including tests. At VGV we strive for 100% test coverage, but if you're unsure on how to do so watch our [Testing Fundamentals Course](https://www.youtube.com/watch?v=M_eZg-X789w&list=PLprI2satkVdFwpxo_bjFkCxXz5RluG8FY).

If you still can't reach full coverage, please let us know in your PR description.

1. Ensure tests still pass locally:

```sh
very_good test
```

1. Format your code:

```sh
dart format lib test
```

1. Analyze your code:

```sh
dart analyze --fatal-infos --fatal-warnings .
```

Some analysis issues may be fixed automatically with:

```sh
dart fix --apply
```

💡 **Note**: Our repositories use [Very Good Analysis](https://github.com/VeryGoodOpenSource/very_good_analysis).

1. Ensure you have a meaningful [semantic][conventional_commits_link] commit message.

1. Create the Pull Request with a meaningful description, linking to the original issue where possible.

1. Verify that all [status checks](https://github.com/VeryGoodOpenSource/formz/actions/) are passing for your Pull Request once they have been approved to run by a maintainer.

💡 **Note**: While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional work, tests, or other changes before your pull request can be accepted.


[conventional_commits_link]: https://www.conventionalcommits.org/en/v1.0.0
[bug_report_link]: https://github.com/VeryGoodOpenSource/formz/issues/new?assignees=&labels=bug&template=bug_report.md&title=fix%3A+
