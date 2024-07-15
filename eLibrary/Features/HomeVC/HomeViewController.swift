//
//  ViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 12/7/24.
//

import UIKit

protocol FormDemoViewInput: FormViewInput{

    var dataSource: FormDataSource { get }

    func configure()
}

protocol FormDemoViewOutput: AnyObject {

    func viewDidLoad()
}

class HomeViewController: FormViewController {
    
    private let containerView = UIView.newAutoLayoutView()
    var output: FormDemoViewOutput?

    override func viewWillAppear(_ animated: Bool) {
        output?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupContainerView()
        setupTableViewConstraints()
    }
    
    func setupContainerView(){
        view.addSubview(containerView)
        containerView.fillToSuperview()
    }
    
    func setupTableViewConstraints() {
            containerView.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
//        containerView.sendSubviewToBack(tableView)
    }

}

extension HomeViewController {
    private func setUpLayout() {}
}

extension HomeViewController: FormDemoViewInput {

    func configure() {
        setUpLayout()
    }
}
