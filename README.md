# versioning_ios plugin

[![Build Status](https://travis-ci.org/beplus/fastlane-plugin-versioning_ios.svg?branch=master)](https://travis-ci.org/beplus/fastlane-plugin-versioning_ios)
[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-versioning_ios)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-versioning_ios`, add it to your project by running:

```bash
fastlane add_plugin versioning_ios
```

## About versioning_ios

iOS Versioning Plugin for Fastlane - easily Get / Set `Build Number` and `Version` on your iOS project.

**Note**: If you need to work with `versionCode` and `versionName` on Android, see [versioning_android](https://github.com/beplus/fastlane-plugin-versioning_android).

### Available actions
- `ios_get_build_number` to get the Build Number
- `ios_get_version` to get the Version
- `ios_set_build_number` to set the new Build Number
- `ios_set_version` to set the new Version

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

### Example project

**@todo** You can find a fully functional setup of this plugin in the [UdemyFastlane](https://github.com/igorlamos/udemy-fastlane) repo, where you can also find more info about versioning of iOS apps.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
