//
//  HomeViewModel.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

final class HomeViewModel {

    func fetchPaymentData(completion: @escaping (Result<[PaymentMethod], APIServiceError>) -> (Void)) {
        let request = PaymentRequest()

        NetworkManager.shared.handleRequest(request,
                                            model: PaymentResponse.self) { (result) -> (Void) in
            switch result {
            case .success(let response):
                completion(.success(response.networks.applicable))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
