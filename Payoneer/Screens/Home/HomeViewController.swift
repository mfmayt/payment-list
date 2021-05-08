//
//  HomeViewController.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

private enum Constant {

    static let startPoint = CGPoint(x: 0.8, y: 1.0)
    static let endPoint = CGPoint(x: 0.2, y: 0.0)
}

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = HomeViewModel()
    private var paymentMethodList: [PaymentMethod] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        applyStyling()
        fetchData()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            guard previousTraitCollection?
                    .hasDifferentColorAppearance(comparedTo: traitCollection) ?? false else {
                return
            }
            setGradient()
        }
    }
}

// MARK: Private Helpers

private extension HomeViewController {

    func configureTableView() {
        tableView.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PaymentMethodTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    func applyStyling() {
        tableView.backgroundColor = .clear
        setGradient()
    }

    func setGradient() {
        view.layer.sublayers = view.layer.sublayers?.filter { theLayer in
            !theLayer.isKind(of: CAGradientLayer.classForCoder())
        }
        let beginColor = Style.getColor(lightVersion: .skyBlue, darkVersion: .darkBlue)
        let endColor = Style.getColor(lightVersion: .lightBlue, darkVersion: .nightBlue)
        view.applyGradient(colors: [beginColor, endColor],
                           startPoint: Constant.startPoint,
                           endPoint: Constant.endPoint)
    }

    func fetchData() {
        viewModel.fetchPaymentData { (result) -> (Void) in
            DispatchQueue.main.async {
                switch result {
                case .success(let paymentMethodList):
                    self.paymentMethodList = paymentMethodList
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showError(error)
                }
            }
        }
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PaymentMethodTableViewCell.reuseIdentifier,
            for: indexPath) as! PaymentMethodTableViewCell
        let token = cell.paymentLogoImageView.setImage(from: paymentMethodList[indexPath.row].links.logo)
        cell.populateCell(with: paymentMethodList[indexPath.row].label)
        cell.onReuse = {
            MediaManager.shared.cancel(for: token )
        }
        return cell
    }
}


// MARK: Private Helpers

private extension HomeViewController {

    func showError(_ error: APIServiceError) {
        let alert = UIAlertController(title: "Try again",
                                      message: "\(error.localizedError)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry",
                                      style: .default,
                                      handler: { (action) in
                                        self.fetchData()
                                      }))
        present(alert, animated: true, completion: nil)
    }
}
