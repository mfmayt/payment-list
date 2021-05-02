//
//  PaymentResponse.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

struct PaymentResponse: Decodable {

    let networks: PaymentNetworks
}

struct PaymentNetworks: Decodable {

    let applicable: [PaymentMethod]
}
