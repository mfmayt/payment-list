//
//  HomeViewController.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

// MARK: Configurations

private extension HomeViewController {

    func configureTableView() {
        tableView.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PaymentMethodTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: will be updated
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PaymentMethodTableViewCell.reuseIdentifier,
            for: indexPath) as! PaymentMethodTableViewCell
        // TODO: populate cell with data
        return cell
    }
}

