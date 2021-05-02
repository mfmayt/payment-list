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
    }

    func fetchData() {
        viewModel.fetchPaymentData { (result) -> (Void) in
            switch result {
            case .success(let paymentMethodList):
                self.paymentMethodList = paymentMethodList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showError(error)
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
}


// MARK: Private Helpers

private extension HomeViewController {

    func showError(_ error: Error) {

    }
}
