//
//  ProfileViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/7/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, Coordinator {
    
    var modalDelegate: ModalDismissDelegate?
    
    init(delegate: ModalDismissDelegate?) {
        self.modalDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView = UIView.newAutoLayoutView()
    private var logOut: UIButton = {
        let logOut = UIButton.newAutoLayoutView()
        logOut.setTitle("Logout", for: .normal)
        logOut.titleLabel?.font = .systemFont(ofSize: 20)
        logOut.setTitleColor(.black, for: .normal)
        logOut.addBottomLine(color: .black, width: 2, bottomAnchor: 5)
        return logOut
    }()
    private var deleteAccount: UIButton = {
        let deleteAccount = UIButton.newAutoLayoutView()
        deleteAccount.setTitle("Delete account", for: .normal)
        deleteAccount.titleLabel?.font = .systemFont(ofSize: 20)
        deleteAccount.setTitleColor(.red, for: .normal)
        deleteAccount.addBottomLine(color: .black, width: 2, bottomAnchor: 5)
        return deleteAccount
    }()
    
    private let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfile()
        
        logOut.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        deleteAccount.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    private func setupProfile() {
        view.addSubview(contentView)
        contentView.fillToSuperview()
        contentView.backgroundColor = .white
        
        contentView.addSubview(logOut)
        contentView.addSubview(deleteAccount)
        
        NSLayoutConstraint.activate([
            logOut.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logOut.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            
            deleteAccount.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deleteAccount.topAnchor.constraint(equalTo: logOut.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func logoutTapped() {
        self.dismiss(animated: true) {
            do {
                try self.firebaseAuth.signOut()
            } catch {
                print("already logged out")
            }
            self.modalDelegate?.actionAfterDismiss()
        }
    }
    
    @objc private func deleteTapped() {
        self.dismiss(animated: true) {
            self.firebaseAuth.currentUser?.delete { error in
                self.modalDelegate?.actionAfterDismiss()
            }
        }
    }
}
