//
//  RNPassLibrary.swift
//
//
//  Created by Kamaal Farah on 19/07/2020.
//

import Foundation

@objc(RNPassLibrary)
class RNPassLibrary: NSObject {

    private let passLibrary = PassLibrary()

    @objc
    func constantsToExport() -> [AnyHashable: Any]! {
        return ["name": "RNPassLibrary"]
    }

    @objc
    func getRemotePKPassAndPresentPKPassView(_ url: String,
                                             resolver resolve: @escaping RCTPromiseResolveBlock,
                                             rejecter reject: @escaping RCTPromiseRejectBlock) {
        self.passLibrary.getRemotePKPass(from: urlPath) { (result: Result<Data, Error>) in
            switch result {
            case .failure(let failure):
                rejecter(failure)
            case .success(let pkpassData):
                DispatchQueue.main.async {
                    guard let keyWindow = UIApplication.shared.keyWindow else {
                        rejecter("Could not get key window")
                        return
                    }
                    do {
                        try passLibrary.presentAddPKPassViewController(window: keyWindow, pkpassData: pkpassData)
                        resolver(true)
                    } catch {
                        rejecter(error.localizedDescription)
                    }
                }
            }
        }
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

}
