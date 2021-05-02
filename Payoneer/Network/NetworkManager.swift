//
//  NetworkManager.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

class NetworkManager {

    public enum APIServiceError: Error {

        case noData
        case decodeError
    }

    private enum Constant {

        static let baseURL = URL(string: "some url")
    }

    static let shared = NetworkManager(baseURL: Constant.baseURL!)

    let baseURL: URL

    private init(baseURL: URL) {
        self.baseURL = baseURL
    }


    func GET(request: BaseRequest, completion: @escaping (Data?, Error?) -> (Void)) {
        let session = URLSession.shared

        let task = session.dataTask(with: request.urlRequest) { (data, urlResponse, error) in
            return completion(data, error)
        }

        task.resume()
    }

    func handleRequest<T: Codable>(_ request: BaseRequest,
                                     model: T.Type,
                                     completion: @escaping (Result<T, Error>) -> (Void)) {

        switch request.method {
        case .GET:
            GET(request: request) { (data, error) -> (Void) in
                self.processResponse(data: data, error: error) { (result) -> (Void) in
                    completion(result)
                }
            }
        }
        // We can add other type of requests here
    }

    func processResponse<T: Codable>(data: Data?,
                                     error: Error?,
                                     completion: @escaping (Result<T, Error>) -> (Void)) {
        if let err = error {
            return completion(.failure(err))
        }
        if let data = data {
            do{
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(APIServiceError.decodeError))
            }
        } else {
            return completion(.failure(APIServiceError.noData))
        }
    }

    func getRESTURL(with endpoint: String)-> String {
        return "\(getPlist(withName: "MediaAPIBaseURL"))/\(endpoint)"
    }
}

// MARK: - Private Helpers

private extension NetworkManager {

    func getMediaURL(with endpoint: String)-> String {
        return "\(getPlist(withName: "MediaAPIBaseURL"))/\(endpoint)"
    }

    func getPlist(withName name: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: name) as? String ?? ""
    }
}
