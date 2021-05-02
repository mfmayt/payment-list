//
//  HomeViewModel.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

protocol HomeDataController {

    func fetchPaymentData(completion: @escaping (Result<[PaymentMethod], APIServiceError>) -> (Void))
}

final class DefaultHomeDataController: HomeDataController {

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

final class HomeViewModel {

    private let dataController:  HomeDataController

    init(dataController: HomeDataController = DefaultHomeDataController()) {
        self.dataController = dataController
    }

    func fetchPaymentData(completion: @escaping (Result<[PaymentMethod], APIServiceError>) -> (Void)) {
        dataController.fetchPaymentData { (result) -> (Void) in
            completion(result)
        }
    }
}
