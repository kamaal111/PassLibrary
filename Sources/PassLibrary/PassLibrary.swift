//
//  PassLibrary.swift
//
//
//  Created by Kamaal Farah on 18/07/2020.
//

import PassKit
import UIKit
import XiphiasNet

public struct PassLibrary {
    private let networker: XiphiasNetable

    internal init(networker: XiphiasNetable = XiphiasNet()) {
        self.networker = networker
    }

    public init() {
        self.networker = XiphiasNet()
    }
}

public extension PassLibrary {
    func getRemotePKPass(from pkpassUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: pkpassUrl) else {
            completion(.failure(PassLibraryError.urlIsNil))
            return
        }
        _getRemotePKPass(from: url, completion: completion)
    }

    func getRemotePKPass(from pkpassUrl: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        _getRemotePKPass(from: pkpassUrl, completion: completion)
    }


    func presentAddPKPassViewController(window: UIWindow?, pkpassData: Data) throws {
        let addPKPassViewController = try self.setupPKAddPassViewController(data: pkpassData)
        guard let rootViewContoller = window?.rootViewController else {
            throw PassLibraryError.loadRootVC
        }
        addPKPassViewController.modalPresentationStyle = .pageSheet
        rootViewContoller.present(addPKPassViewController, animated: true, completion: nil)
    }
}

public extension PassLibrary {
    enum PassLibraryError: Error {
        case createVC
        case loadRootVC
        case urlIsNil
    }
}

extension PassLibrary.PassLibraryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .createVC:
            return "Failed to create add pass view controller"
        case .loadRootVC:
            return "Failed to load root view controller"
        case .urlIsNil:
            return "URL evaluates to nil"
        }
    }
}

private extension PassLibrary {
    private func _getRemotePKPass(from pkpassUrl: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        networker.requestData(from: pkpassUrl) { (result: Result<Data, Error>) in
            completion(result)
        }
    }

    private func setupPKAddPassViewController(data: Data) throws -> PKAddPassesViewController {
        let pkpass = try PKPass(data: data)
        guard let addPKPassViewController = PKAddPassesViewController(pass: pkpass) else {
            throw PassLibraryError.createVC
        }
        return addPKPassViewController
    }
}
