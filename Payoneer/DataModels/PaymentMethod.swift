//
//  PaymentMethod.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import Foundation

struct PaymentMethod: Decodable {

    let label: String
    let links: MethodLink
}
