//
//  BaseRequest.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

public enum HTTPMethod: String {

    case GET = "GET"
}

protocol BaseRequest {

    var endpoint: String { get }
    var method: HTTPMethod { get }
}

extension BaseRequest {

    var urlRequest: URLRequest {
        let url = NetworkManager.shared.getRESTURL(with: endpoint)

        return URLRequest(url: URL(string: url)!)
    }
}

