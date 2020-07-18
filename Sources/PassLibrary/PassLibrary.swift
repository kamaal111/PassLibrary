//
//  PassLibrary.swift
//
//
//  Created by Kamaal Farah on 18/07/2020.
//

import PassKit
import UIKit

public final class PassLibrary {

    private let networker: Networkable

    internal init(networker: Networkable = Networker()) {
        self.networker = networker
    }

    public init() {
        self.networker = Networker()
    }

    public enum PassLibraryError: Error {
        case failedToCreatePKPass(message: String)
        case failedToCreateVC(message: String)
        case failedToLoadRootVC(message: String)
    }

    public func getRemotePKPass(from pkpassUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        self.networker.getPKPass(from: pkpassUrl) { (result: Result<Data, Error>) in
            completion(result)
        }
    }

    public func pressAddPassButtonAction(window: UIWindow?, pkpassData: Data) throws {
        var addPKPassViewController: PKAddPassesViewController?
        do {
            addPKPassViewController = try self.setupPKAddPassViewController(data: pkpassData)
        } catch {
            throw error
        }
        guard let viewControllerToPresent = addPKPassViewController else {
            throw PassLibraryError.failedToCreateVC(message: "Failed to create add pass view controller")
        }
        guard let rootViewContoller = window?.rootViewController else {
            throw PassLibraryError.failedToLoadRootVC(message: "Failed to load root view controller")
        }
        viewControllerToPresent.modalPresentationStyle = .pageSheet
        rootViewContoller.present(viewControllerToPresent, animated: true, completion: nil)
    }

    private func setupPKAddPassViewController(data: Data) throws -> PKAddPassesViewController {
        var pkpass: PKPass?
        do {
            pkpass = try PKPass(data: data)
        } catch {
            throw PassLibraryError.failedToCreatePKPass(message: error.localizedDescription)
        }
        guard pkpass != nil else {
            throw PassLibraryError.failedToCreatePKPass(message: "Could not unwrap pkpass")
        }
        guard let addPKPassViewController = PKAddPassesViewController(pass: pkpass!) else {
            throw PassLibraryError.failedToCreateVC(message: "Failed to create add pass view controller")
        }
        return addPKPassViewController
    }

}
