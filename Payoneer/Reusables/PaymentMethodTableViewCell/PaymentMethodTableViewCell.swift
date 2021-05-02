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
    }

    @IBOutlet private weak var paymentLogoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        applyStyling()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        paymentLogoImageView.image = nil
    }
}

// MARK: - UI Methods

private extension PaymentMethodTableViewCell {

    func applyStyling() {
        selectionStyle = .none
        paymentLogoImageView.contentMode = .scaleAspectFit

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: Constant.titleFontSize, weight: .semibold)
    }
}

// MARK: - Public Methods

extension PaymentMethodTableViewCell {

    func populateCell(with paymentData: PaymentMethod) {
        titleLabel.text = paymentData.label
        paymentLogoImageView.setImage(from: paymentData.links.logo)
    }
}
