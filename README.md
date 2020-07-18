# PassLibrary

A Library to open PKPasses

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/93f62ad927354005bace45e6bff5346f)](https://www.codacy.com/manual/kamaal111/PassLibrary?utm_source=github.com&utm_medium=referral&utm_content=kamaal111/PassLibrary&utm_campaign=Badge_Grade)

| branch  | status                                                                                        |
| ------- | --------------------------------------------------------------------------------------------- |
| master  | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=master)          |
| develop | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=develop)         |
| v1.0.0  | ![CI](https://github.com/kamaal111/PassLibrary/workflows/CI/badge.svg?branch=release%2F1.0.0) |

## Usage

### With App Lifecycle

```swift
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
```

### With SceneDelegate

```swift
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
```

### With UIApplication

```swift
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
```
