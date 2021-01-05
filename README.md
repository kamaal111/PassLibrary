# PassLibrary

A library to open PKPasses

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/93f62ad927354005bace45e6bff5346f)](https://www.codacy.com/manual/kamaal111/PassLibrary?utm_source=github.com&utm_medium=referral&utm_content=kamaal111/PassLibrary&utm_campaign=Badge_Grade)

## Installation

### Swift Package Manager

- In your XCode Project select File > Swift Packages > Add Package Dependency and enter `https://github.com/kamaal111/PassLibrary`
- Select desired version

### Cocoa Pods

- You want to add pod 'PassLibrary', '~> 2.1' similar to the following to your Podfile:

```ruby
target 'MyApp' do
  pod 'PassLibrary', '~> 2.1'
end
```

- Then run a pod install inside your terminal

```bash
pod install
```

## Usage

### From a UIKit ViewController

```swift
...
import PassLibrary

func action() {
    guard let url = URL(string: "https://server.api/pass/123") else { return }
    let passLibrary = PassLibrary()
    passLibrary.presentAddPKPassViewController(self, from: url)
}
```

### From SwiftUI

Use this library [PassLibrarySUI](https://github.com/kamaal111/PassLibrarySUI)

### With SceneDelegate

```swift
...
import PassLibrary

func action() {
    guard let url = URL(string: "https://server.api/pass/123") else { return }
    let passLibrary = PassLibrary()
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
    passLibrary.presentAddPKPassViewController(sceneDelegate.window, from: url)
}
```

### With UIApplication

```swift
...
import PassLibrary

func action() {
    guard let url = URL(string: "https://server.api/pass/123") else { return }
    let passLibrary = PassLibrary()
    let keyWindow = UIApplication.shared.keyWindow
    passLibrary.presentAddPKPassViewController(keyWindow, from: url)
}
```

MIT License

Copyright (c) 2020-2021 Kamaal Farah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
