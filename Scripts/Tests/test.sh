#!/bin/sh

workspace=".swiftpm/xcode/package.xcworkspace"
scheme="PassLibrary"

destinations=(
  "platform=iOS Simulator,name=iPhone 11 Pro Max"
)

xcode_test() {
  set -o pipefail && xcodebuild test -workspace "$workspace" -scheme "$1" -destination "$2" | xcpretty || exit 1
}

test_all_destinations() {
  time {
    for destination in "${destinations[@]}"
    do
      xcode_test "$scheme" "$destination"
    done
  }
}

test_all_destinations