//
//  ViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 12/7/24.
//

import UIKit
import FirebaseCore

protocol FormDemoViewInput: FormViewInput, Coordinator {
    
    var dataSource: FormDataSource { get }
    
    func configure()
}

protocol FormDemoViewOutput: AnyObject {
    
    func viewDidLoad(index: Int)
    func searchBooks(query: String, index: Int)
    func loadMoreData(query: String, index: Int, completion: @escaping () -> Void)
}

protocol ModalDismissDelegate {
    func actionAfterDismiss()
}

class HomeViewController: FormViewController {
    
    private let containerView = UIView.newAutoLayoutView()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar.newAutoLayoutView()
        searchBar.placeholder = "Search books"
        searchBar.barTintColor = .systemGroupedBackground
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private var titleLabel: UILabel = {
        let titleLabel = UILabel.newAutoLayoutView()
        titleLabel.text = "Your e-Library"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return titleLabel
    }()
    private var profile: UIButton = {
        let profile = UIButton.newAutoLayoutView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: configuration)
        profile.setImage(image, for: .normal)
        profile.tintColor = .black
        return profile
    }()
    private var headerView = UIView.newAutoLayoutView()
    
    var loadingData = false
    var startIndex = 20
    var getQuery = "Swift"
    var output: FormDemoViewOutput?
    var delegate: ModalDismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad(index: 0)
        // Do any additional setup after loading the view.
        setupHeaderView()
        setupContainerView()
        setupTableViewConstraints()
        
        delegate = self
        profile.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    @objc private func profileTapped() {
        if FirebaseApp.app() == nil {
            
        } else {
            self.navigate(NavigationItem(page: .profile(delegate: delegate), navigationStyle: .present(animated: true)))
        }
    }
    
    //MARK: - UI
    private func setupHeaderView() {
        // Setup the searchBar
        searchBar.delegate = self
        view.backgroundColor = .systemGroupedBackground
        
        // Create a container for the header view
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        headerView.addSubview(searchBar)
        headerView.addSubview(titleLabel)
        headerView.addSubview(profile)
        
        // Set up constraints for the titleLabel and searchBar
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -6),
            
            // Profile Constrains
            profile.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            profile.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -12),
            profile.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -6),
            profile.widthAnchor.constraint(equalToConstant: 40),
            profile.heightAnchor.constraint(equalToConstant: 40),
            
            // Search Bar Constraints
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    private func setupNavigationBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func setupContainerView(){
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let threshold = 10
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        let remainingRows = totalRows - indexPath.row
        
        if !loadingData && remainingRows < threshold && !dataSource.fields.isEmpty {
            loadingData = true
            startIndex += 20
            output?.loadMoreData(query: getQuery, index: startIndex) {
                self.loadingData = false
            }
        }
    }
}

extension HomeViewController: ModalDismissDelegate {
    func actionAfterDismiss() {
        self.navigate(NavigationItem(page: .login, navigationStyle: .replace(animated: true)))
    }
}

extension HomeViewController {
    private func setUpLayout() {}
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        output?.searchBooks(query: searchTerm, index: 0)
        startIndex = 0
        getQuery = searchTerm
        searchBar.resignFirstResponder()
        if !dataSource.fields.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

extension HomeViewController: FormDemoViewInput {
    
    func configure() {
        setUpLayout()
    }
}
