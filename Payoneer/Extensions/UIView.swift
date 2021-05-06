//
//  UIView.swift
//  Payoneer
//
//  Created by fatih maytalman on 6.05.2021.
//

import UIKit

extension UIView {

    @discardableResult
    func applyGradient(colors: [UIColor],
                       startPoint: CGPoint,
                       endPoint: CGPoint) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        layer.insertSublayer(gradient, at: 0)

        return gradient
    }
}
