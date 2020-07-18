# PassLibrary

A description of this package.

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
