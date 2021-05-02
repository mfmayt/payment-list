//
//  NetworkManager.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

public enum APIServiceError: Error {
    // TODO: we can increase number of error cases
    case noData
    case decodeError
    case serverError

    var localizedError: String {
        switch self {
        case .decodeError:
            return "an error occuring while decoding data"
        case .noData:
            return "there is no data to shown"
        case .serverError:
            return "an error occured on server side"
        }
    }
}

class NetworkManager {

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
                                     completion: @escaping (Result<T, APIServiceError>) -> (Void)) {

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
                                       completion: @escaping (Result<T, APIServiceError>) -> (Void)) {

        guard error == nil else { return completion(.failure(APIServiceError.serverError)) }

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
