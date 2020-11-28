# PassLibrary

A library to open PKPasses

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/93f62ad927354005bace45e6bff5346f)](https://www.codacy.com/manual/kamaal111/PassLibrary?utm_source=github.com&utm_medium=referral&utm_content=kamaal111/PassLibrary&utm_campaign=Badge_Grade)

## Installation

### Swift Package Manager

- In your XCode Project select File > Swift Packages > Add Package Dependency and enter `https://github.com/kamaal111/PassLibrary`
- Select desired version

## Usage

### With SceneDelegate

```swift
import PassLibrary

func action() {
    guard let url = URL(string: "https://server.api/pass/123") else { return }
    let passLibrary = PassLibrary() // From PassLibrary
    passLibrary.getRemotePKPass(from: url) { (result: Result<Data, Error>) in
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
    guard let url = URL(string: "https://server.api/pass/123") else { return }
    let passLibrary = PassLibrary() // From PassLibrary
    passLibrary.getRemotePKPass(from: url) { (result: Result<Data, Error>) in
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
                }
            }
        }
    }
}
```

### With React-Native

#### Preparation

- From XCode create a new Swift file in your project directory. Name it `RNPassLibrary`.
- If you have not created a Objective-C header before, a pop up will appear. Select `Create Bridging Header`.
- Add `#import <React/RCTBridgeModule.h>` in your `Bridging Header` file.
- In `RNPassLibrary.swift` add the following code:

```swift
import PassLibrary
import UIKit

@objc(RNPassLibrary)
class RNPassLibrary: NSObject {

    private let passLibrary = PassLibrary() // From PassLibrary

    @objc
    func constantsToExport() -> [AnyHashable: Any]! {
        return ["name": "RNPassLibrary"]
    }

    @objc
    func getRemotePKPassAndPresentPKPassView(_ urlString: String,
                                            resolver resolve: @escaping RCTPromiseResolveBlock,
                                            rejecter reject: @escaping RCTPromiseRejectBlock) {
        guard let pkPassUrl = URL(string: urlString) else {
            // Handle with rejecter
            return
        }
        self.passLibrary.getRemotePKPass(from: pkPassUrl) { (result: Result<Data, Error>) in
            switch result {
            case .failure(let failure):
                reject("error", failure.localizedDescription, failure)
            case .success(let pkpassData):
                DispatchQueue.main.async {
                    guard let keyWindow = UIApplication.shared.keyWindow else {
                        // Handle with rejecter
                        return
                    }
                    do {
                        try self.passLibrary.presentAddPKPassViewController(window: keyWindow, pkpassData: pkpassData)
                        resolve(true)
                    } catch {
                        reject("error", error.localizedDescription, error)
                    }
                }
            }
        }
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        true
    }

}
```

- Create a new Objective-C file. Name it `RNPassLibrary`.
- In `RNPassLibrary.m` add the following code:

```objectivec
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNPassLibrary, NSObject)

RCT_EXTERN_METHOD(
    getRemotePKPassAndPresentPKPassView: (NSString *)string
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject
    )

@end
```

#### Implementation

```javascript
import { NativeModules, Platform } from "react-native";

const { RNPassLibrary } = NativeModules;

const onPress = async () => {
  const isIOS = Platform.OS === "ios";
  if (isIOS) {
    try {
      const url = "https://server.api/pass/123";
      await RNPassLibrary.getRemotePKPassAndPresentPKPassView(url);
    } catch (error) {
      // Handle thrown error appropriately
    }
  }
};
```

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
