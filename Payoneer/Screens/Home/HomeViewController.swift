//
//  HomeViewController.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = HomeViewModel()
    private var paymentMethodList: [PaymentMethod] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        fetchData()
    }
}

// MARK: Configurations

private extension HomeViewController {

    func configureTableView() {
        tableView.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PaymentMethodTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
        cell.populateCell(with: paymentMethodList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment Methods"
    }
}


// MARK: Private Helpers

private extension HomeViewController {

    func showError(_ error: APIServiceError) {
        // TODO: we can move these texts to localization files
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
