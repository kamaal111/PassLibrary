//
//  Networker.swift
//  
//
//  Created by Kamaal Farah on 18/07/2020.
//

import Foundation

internal protocol Networkable {
    func getPKPass(from pkpassUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}

internal class Networker: Networkable {
    internal init() { }

    internal enum NetworkerErrors: Error {
        case responseError(message: String, code: Int)
        case dataError(message: String, code: Int)
    }

    internal func getPKPass(from pkpassUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let dispatchQueue = DispatchQueue(label: "get-pkpass", qos: .utility, attributes: .concurrent)
        dispatchQueue.async {
            guard let url = URL(string: pkpassUrl) else {
                completion(.failure(NSError(domain: "url error", code: 400, userInfo: nil)))
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    let error = NetworkerErrors.responseError(message: "response code error",
                                                              code: response.statusCode)
                    completion(.failure(error))
                    return
                }
                guard let dataResponse = data else {
                    let error = NetworkerErrors.dataError(message: "data error", code: 400)
                    completion(.failure(error))
                    return
                }
                completion(.success(dataResponse))
            }
            .resume()
        }
    }
}
