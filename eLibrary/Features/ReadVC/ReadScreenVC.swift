//
//  ReadScreenVC.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 17/7/24.
//

import UIKit
import WebKit

class ReadScreenVC: UIViewController {
    
    private let webView = WKWebView.newAutoLayoutView()
    private var navbar: UINavigationBar = {
        let navBar = UINavigationBar.newAutoLayoutView()
        navBar.barTintColor = .white
        return navBar
    }()
    private var navItem = UINavigationItem()
    
    private let bookData: Book
    
    init(bookData: Book) {
        self.bookData = bookData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupWebView()
        loadBookContent()
    }
    
    private func setupNavBar() {
        view.addSubview(navbar)
        navItem.titleView = makeMultilineTitleLabel(text: bookData.title)
        let backButtonImage = UIImage(systemName: "arrow.backward")
        navItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navItem.leftBarButtonItem?.tintColor = .black
        navbar.items = [navItem]
        
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupWebView() {
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: navbar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadBookContent() {
        if let url = URL(string: bookData.url ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func makeMultilineTitleLabel(text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.numberOfLines = 2
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            return label
        }
}
