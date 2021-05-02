//
//  MockDataProvider.swift
//  PayoneerTests
//
//  Created by fatih maytalman on 3.05.2021.
//

@testable import Payoneer

final class HomeDataProviderMock: HomeDataController {

    var result: Result<[PaymentMethod], APIServiceError>?

    func fetchPaymentData(completion: @escaping (Result<[PaymentMethod], APIServiceError>) -> (Void)) {
        guard let result = result else { return }
        completion(result)
    }
}
