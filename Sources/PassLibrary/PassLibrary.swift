//
//  PassLibrary.swift
//
//
//  Created by Kamaal Farah on 18/07/2020.
//

import PassKit
import UIKit

public struct PassLibrary {
    public init() { }
}

public extension PassLibrary {
    func presentAddPKPassViewController(_ window: UIWindow?, from pkpassUrl: URL) throws {
        let pkpass = try getRemotePKPass(from: pkpassUrl)
        guard let addPKPassViewController = PKAddPassesViewController(pass: pkpass) else {
            throw PassLibraryError.createVC
        }
        guard let rootViewContoller = window?.rootViewController else {
            throw PassLibraryError.loadRootVC
        }
        addPKPassViewController.modalPresentationStyle = .pageSheet
        rootViewContoller.present(addPKPassViewController, animated: true, completion: nil)
    }

    func presentAddPKPassViewController(_ viewController: UIViewController, from pkpassUrl: URL) throws {
        let pkpass = try getRemotePKPass(from: pkpassUrl)
        guard let addPKPassViewController = PKAddPassesViewController(pass: pkpass) else {
            throw PassLibraryError.createVC
        }
        addPKPassViewController.modalPresentationStyle = .pageSheet
        viewController.present(addPKPassViewController, animated: true, completion: nil)
    }
}

public extension PassLibrary {
    enum PassLibraryError: Error {
        case createVC
        case loadRootVC
    }
}

private extension PassLibrary {
    private func getRemotePKPass(from pkpassUrl: URL) throws -> PKPass {
        let data = try Data(contentsOf: pkpassUrl, options: .mappedIfSafe)
        let pkpass = try PKPass(data: data)
        return pkpass
    }
}

extension PassLibrary.PassLibraryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .createVC:
            return "Failed to create add pass view controller"
        case .loadRootVC:
            return "Failed to load root view controller"
        }
    }
}
