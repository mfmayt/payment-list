//
//  ViewController.swift
//  Payoneer
//
//  Created by fatih maytalman on 2.05.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

private extension ViewController {

    func configureTableView() {
        tableView.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PaymentMethodTableViewCell.reuseIdentifier)
    }
}

