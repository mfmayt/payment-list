//
//  PaymentMethodTableViewCell.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

final class PaymentMethodTableViewCell: UITableViewCell {

    private enum Constant {

        static let titleFontSize: CGFloat = 15.0
        static let urlFontSize: CGFloat = 11.0
    }

    @IBOutlet private weak var paymentLogoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        applyStyling()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = ""
        paymentLogoImageView.image = nil
    }
}

// MARK: - UI Methods

private extension PaymentMethodTableViewCell {

    func applyStyling() {
        selectionStyle = .none
        paymentLogoImageView.contentMode = .scaleAspectFill

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: Constant.titleFontSize, weight: .semibold)
    }
}

// MARK: - Public Methods

extension PaymentMethodTableViewCell {

    // TODO: will be populated via presentation data
    func populateCell() {
        titleLabel.text = item.title
        dataTask = paymentLogoImageView.setImage(from: item.url)
    }
}
