//
//  Style.swift
//  Payoneer
//
//  Created by fatih maytalman on 6.05.2021.
//

import UIKit

class Style {

    static func getColor(lightVersion: UIColor, darkVersion: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            let color = UIColor { (traitCollection: UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? darkVersion : lightVersion
            }
            return color
        } else {
            return lightVersion
        }
    }
}
