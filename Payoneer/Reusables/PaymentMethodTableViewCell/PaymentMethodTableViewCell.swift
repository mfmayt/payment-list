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
        static let cornerRadius: CGFloat = 6.0
        static let shadowOpacity: Float = 0.2
        static let backgroundOpacity: CGFloat = 0.7
    }

    @IBOutlet weak var paymentLogoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentHolderView: UIView!

    var onReuse: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()

        applyStyling()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        paymentLogoImageView.image = nil
        onReuse()
    }
}

// MARK: - UI Methods

private extension PaymentMethodTableViewCell {

    func applyStyling() {
        selectionStyle = .none
        backgroundColor = .clear

        paymentLogoImageView.contentMode = .scaleAspectFit

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: Constant.titleFontSize, weight: .semibold)
        contentHolderView.layer.shadowColor = UIColor.darkGray.cgColor
        contentHolderView.layer.shadowOpacity = Constant.shadowOpacity
        contentHolderView.layer.shadowOffset = .zero
        contentHolderView.layer.shadowRadius = Constant.cornerRadius
        contentHolderView.layer.cornerRadius = Constant.cornerRadius
        contentHolderView.backgroundColor = Style
            .getColor(lightVersion: .cream, darkVersion: .purplyBlue)
            .withAlphaComponent(Constant.backgroundOpacity)
    }
}

// MARK: - Public Methods

extension PaymentMethodTableViewCell {

    func populateCell(with label: String) {
        titleLabel.text = label
    }
}
