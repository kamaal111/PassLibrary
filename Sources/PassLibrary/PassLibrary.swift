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
    func getRemotePKPass(from pkpassUrl: URL) throws -> Data {
        try Data(contentsOf: pkpassUrl, options: .mappedIfSafe)
    }


    func presentAddPKPassViewController(window: UIWindow?, pkpassData: Data) throws {
        guard let addPKPassViewController = try setupPKAddPassViewController(data: pkpassData) else {
            throw PassLibraryError.createVC
        }
        guard let rootViewContoller = window?.rootViewController else {
            throw PassLibraryError.loadRootVC
        }
        addPKPassViewController.modalPresentationStyle = .pageSheet
        rootViewContoller.present(addPKPassViewController, animated: true, completion: nil)
    }

    func presentAddPKPassViewController(viewController: UIViewController, pkpassData: Data) throws {
        guard let addPKPassViewController = try setupPKAddPassViewController(data: pkpassData) else {
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

private extension PassLibrary {
    private func setupPKAddPassViewController(data: Data) throws -> PKAddPassesViewController? {
        let pkpass = try PKPass(data: data)
        return PKAddPassesViewController(pass: pkpass)
    }
}
