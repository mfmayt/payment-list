//
//  HomeViewModel.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

final class HomeViewModel {

    func fetchPaymentData() {
        let request = PaymentRequest()

        NetworkManager.shared.handleRequest(request,
                                            model: PaymentResponse.self) { (result) -> (Void) in
            switch result {
            case .success(let response):
                print(response.networks.applicable.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
