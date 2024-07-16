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
    func searchBooks(query: String)
}

class HomeViewController: FormViewController {
    
    private let containerView = UIView.newAutoLayoutView()
    private let searchBar = UISearchBar.newAutoLayoutView()
    
    var output: FormDemoViewOutput?

    override func viewWillAppear(_ animated: Bool) {
        output?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchBar()
        setupContainerView()
        setupTableViewConstraints()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search books"
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupContainerView(){
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableViewConstraints() {
            containerView.addSubview(tableView)
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        output?.searchBooks(query: searchTerm)
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: FormDemoViewInput {

    func configure() {
        setUpLayout()
    }
}
