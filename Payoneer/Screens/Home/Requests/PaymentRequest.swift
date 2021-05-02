//
//  PaymentRequest.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

struct PaymentRequest: BaseRequest {

    private enum Constant {
        static let endpoint = "optiloooo/checkout-android/develop/shared-test/lists/listresult.json"
    }

    let endpoint: String = Constant.endpoint
    let method: HTTPMethod = .GET
}
