//
//  UIImageView.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

extension UIImageView {

    @discardableResult
    func setImage(from url: String) -> UUID? {
        guard let url = URL(string: url) else { return nil }

        let uuid = UUID()
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        MediaManager.shared.load(url, uuid: uuid) { (result) -> (Void) in
            DispatchQueue.main.async() { [weak self] in
                switch result {
                    case .failure(_):
                        self?.image = nil
                    case .success(let image):
                        self?.image = image
                }
            }
        }
        backgroundColor = .clear
        return uuid
    }
}
