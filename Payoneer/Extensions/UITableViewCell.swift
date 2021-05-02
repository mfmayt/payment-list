//
//  UITableViewCell.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

extension UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
