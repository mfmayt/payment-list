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

        static let baseURL = "https://raw.githubusercontent.com"
    }

    static let shared = NetworkManager(baseURL: Constant.baseURL)

    let baseURL: String

    private init(baseURL: String) {
        self.baseURL = baseURL
    }


    func GET(request: BaseRequest, completion: @escaping (Data?, Error?) -> (Void)) {
        let session = URLSession.shared

        let task = session.dataTask(with: request.urlRequest) { (data, urlResponse, error) in
            return completion(data, error)
        }

        task.resume()
    }

    func handleRequest<T: Decodable>(_ request: BaseRequest,
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
    }

    func processResponse<T: Decodable>(data: Data?,
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

        return "\(baseURL)/\(endpoint)"
    }
}
