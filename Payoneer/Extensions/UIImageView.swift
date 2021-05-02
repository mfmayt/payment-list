//
//  UIImageView.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

extension UIImageView {

    // We can store the data tasks and cancel not needed ones when scrolling fast/big size images
    @discardableResult
    func setImage(from url: String) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }

        dataTask.resume()
        return dataTask
    }
}
