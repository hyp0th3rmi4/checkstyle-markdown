# Checkstyle Markdown

A GitHub action that converts a checkstyle report XML document into Markdown. It can be used together with [PR Comment File](https://github.com/marketplace/actions/pr-comment-from-file) to publish the result of a checkstyle report as a comment to the checkstyle request.

# Usage

Add `.github/workflows/publish-checkstyle.yaml` with the following:

```yaml
name: PR Checkstyle Report
on:
  pull_request: 
    types: [opened, reopened, synchronize]

jobs:
  build-and-check:
  runs-on: ubuntu-latest 
  steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        distribution: 'zulu' 
        java-version: '11'
        cache: maven
    - run: mvn checkstyle:checkstyle

    - uses: hyp0th3rmi4/checkstyle-markdown
      with: 
        REPORT_PATH: target/checkstyle-result.xml
        OUTPUT_PATH: target/checkstyle-result.md
```
> **NOTE**: The example assumes the GitHub repository containing Java source code with a standard Apache Maven project. The checkstyle plugin has been configured to output the result of the analysis to the path repository path: `target/checkstyle-result.md` (default behaviour).

As previously mentioned the action can be used in conjunction with the action [PR Comment from File](https://github.com/marketplace/actions/pr-comment-from-file) to publish the Markdown document as a PR comment:

```yaml
name: PR Checkstyle Report
on:
  pull_request: 
    types: [opened, reopened, synchronise]

jobs:
  build-and-check:
  runs-on: ubuntu-latest 
  steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        distribution: 'zulu' 
        java-version: '11'
        cache: maven
    - run: mvn checkstyle:checkstyle

    - uses: hyp0th3rmi4/checkstyle-markdown
      with: 
        REPORT_PATH: target/checkstyle-result.xml
        OUTPUT_PATH: target/checkstyle-result.md

    - uses: machine-learning-apps/pr-comment@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        path: target/checkstyle.md
```

## Configuration

You can customise the action behaviour by controlling the following parameters:

| Parameter Name | Description | Default Value |
|:---------------|:------------|:-------------:|
| *OUTPUT_PATH*  | Path to the file where to save the markdown document containing the report. The path is relative to the repository root. | N/A |
| *REPORT_PATH*  | Path to the file containing the checkstyle report. The path is relative to the repository root. | N/A |
| *ROOT_PREFIX*  | Common path root for all examined files relative to the repository root. | `src/main/java/` |
| *ERROR_ICON*   | Emoji (or any markdown text) used for checkstyle findings identified as errors. | `ERROR` |
| *WARNING_ICON* | Emoji (or any markdown text) used for checkstyle findings identified as warnings. | `WARNING` |
| *INFO_ICON*    | Emoji (or any markdown text) used for checkstyle findings identified as informative messages. | `INFO` |

> **NOTE**: both *OUtPUT_PATH* and *REPORT_PATH* are relative paths and must NOT start with `/`.

Below is an example for generating a report that uses emojis and modifies the default value of the root prefix to adapt to a non-custom layout of a Java project.

```yaml

    ....
    - name: Checkstyle to Markdown
      uses: hyp0th3rmi4/checkstyle-markdown@v1
      with:
        REPORT_PATH: application/target/checkstyle-result.xml
        OUTPUT_PATH: application/target/checkstyle-result.md
        ROOT_PREFIX: src/code/java/
        ERROR_ICON: ":x:"
        WARNING_ICON: ":warning:"
        INFO_ICON: ":envelope:"
    ....
```

> **NOTE**: while it is possible to visualise both errors, warnings, and informative messages, what is eventually rendered depends upon the configuration of the checkstyle plugin which determines the entries that are written by the analyser in the report.

