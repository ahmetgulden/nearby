//
//  NetworkManager.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

private enum Constants {
    static let contentTypeKey = "Content-Type"
    static let defaultContentType = "application/json"
}

/// Class for executing network operations.
final class NetworkManager {

    private static let decoder = JSONDecoder()

    /// Sends a request and receives related response.
    ///
    /// - Parameters:
    ///   - request: Request to be sent.
    ///   - completion: Handler to be executed after task is finished.
    func send<T: Response>(_ request: Request, completion:((NetworkResult<T>) -> ())?) {
        var components = URLComponents(string: request.host.rawValue.appending(request.endpoint))
        var parameters = request.host.additionalParameters
        parameters.merge(request.parameters) { (_, new) in new }
        if request.method != .post {
            components?.query = parameters.nrb_parametersForGet
        }
        guard let url = components?.url else {
            completion?(NetworkResult.failure(error: .brokenURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if request.method == .post {
            urlRequest.httpBody = parameters.nrb_parametersForPost
        }
        urlRequest.setValue(Constants.defaultContentType,
                            forHTTPHeaderField: Constants.contentTypeKey)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion?(NetworkResult.failure(
                    error: .responseError(message: error.localizedDescription)))
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                completion?(NetworkResult.failure(
                    error: .responseError(message: "Unable to fetch data")))
                print("Unable to fetch data")
                return
            }
            do {
                let decodedData: T = try NetworkManager.decoder.decode(T.self,
                                                                       from: data)
                completion?(NetworkResult.success(response: decodedData))
            } catch {
                completion?(NetworkResult.failure(error: NetworkError.decodeError))
                print("Decode Error")
            }
        }.resume()
    }
}
