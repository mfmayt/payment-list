//
//  UIColor.swift
//  Payoneer
//
//  Created by fatih maytalman on 6.05.2021.
//

import UIKit

extension UIColor {

    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }

        return nil
    }

    class var cream: UIColor { return UIColor(hex: "#e4dfd9") ?? .clear }

    class var skyBlue: UIColor { return UIColor(hex: "#5e72eb") ?? .clear }

    class var purplyBlue: UIColor { return UIColor(hex: "#3b5284") ?? .clear }

    class var lightBlue: UIColor { return UIColor(hex: "#5ce6ff") ?? .clear }

    class var nightBlue: UIColor { return UIColor(hex: "#120c6e") ?? .clear }

    class var darkBlue: UIColor { return UIColor(hex: "#0b0742") ?? .clear }
}
