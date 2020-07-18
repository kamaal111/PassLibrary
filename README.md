# PassLibrary

A Library to open PKPasses

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/93f62ad927354005bace45e6bff5346f)](https://www.codacy.com/manual/kamaal111/PassLibrary?utm_source=github.com&utm_medium=referral&utm_content=kamaal111/PassLibrary&utm_campaign=Badge_Grade)

| branch  | status                                                                                        |
| ------- | --------------------------------------------------------------------------------------------- |
| master  | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=master)          |
| develop | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=develop)         |
| v1.0.0  | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=release%2F1.0.0) |

## Installation

### Swift Package Manager

    - In your XCode Project select File > Swift Packages > Add Package Dependency and enter `https://github.com/kamaal111/PassLibrary`
    - Select desired version

## Usage

### With App Lifecycle

```swift
import PassLibrary

func action() {
    let passLibrary = PassLibrary()
    let urlPath = "https://server.api/pass/123"
    passLibrary.getRemotePKPass(from: urlPath) { (result: Result<Data, Error>) in
        switch result {
        case .failure(let failure):
            // Handle failure appropriately
            print(failure)
        case .success(let pkpassData):
            DispatchQueue.main.async {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                do {
                    try passLibrary.presentAddPKPassViewController(window: keyWindow, pkpassData: pkpassData)
                } catch {
                    // Handle thrown error appropriately
                    print(error.localizedDescription)
                }
            }
        }
    }
}
```

### With SceneDelegate

```swift
import PassLibrary

func action() {
    let passLibrary = PassLibrary()
    let urlPath = "https://server.api/pass/123"
    passLibrary.getRemotePKPass(from: urlPath) { (result: Result<Data, Error>) in
        switch result {
        case .failure(let failure):
            // Handle failure appropriately
            print(failure)
        case .success(let pkpassData):
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
                do {
                    try passLibrary.presentAddPKPassViewController(window: sceneDelegate.window, pkpassData: pkpassData)
                } catch {
                    // Handle thrown error appropriately
                    print(error.localizedDescription)
                }
            }
        }
    }
}
```

### With UIApplication

```swift
import PassLibrary

func action() {
    let passLibrary = PassLibrary()
    let urlPath = "https://server.api/pass/123"
    passLibrary.getRemotePKPass(from: urlPath) { (result: Result<Data, Error>) in
        switch result {
        case .failure(let failure):
            // Handle failure appropriately
            print(failure)
        case .success(let pkpassData):
            DispatchQueue.main.async {
                guard let keyWindow = UIApplication.shared.keyWindow else { return }
                do {
                    try passLibrary.presentAddPKPassViewController(window: keyWindow, pkpassData: pkpassData)
                } catch {
                    // Handle thrown error appropriately
                    print(error.localizedDescription)
                }
            }
        }
    }
}
```

```code
MIT License

Copyright (c) 2020 Kamaal Farah

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
```
