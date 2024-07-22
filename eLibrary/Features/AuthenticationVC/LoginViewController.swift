//
//  LoginViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 19/7/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Coordinator {
    
    private let viewModel = AuthenticationViewModel()
    
    private var contentView = UIView.newAutoLayoutView()
    private var welcLabel: UILabel = {
        let welcLabel = UILabel.newAutoLayoutView()
        welcLabel.text = "Welcome,"
        welcLabel.font = .boldSystemFont(ofSize: 34)
        return welcLabel
    }()
    private var descLabel: UILabel = {
        let descLabel = UILabel.newAutoLayoutView()
        descLabel.text = "Log in to your account \nand start reading!"
        descLabel.numberOfLines = 2
        descLabel.font = .systemFont(ofSize: 22)
        return descLabel
    }()
    private var emailField: UITextField = {
        let emailField = UITextField.newAutoLayoutView()
        emailField.placeholder = "Email"
        emailField.addBottomLine(color: .black.withAlphaComponent(0.5), width: 1.5, bottomAnchor: 6)
        emailField.font = .systemFont(ofSize: 16)
        return emailField
    }()
    private var passwordField: UITextField = {
        let passwordField = UITextField.newAutoLayoutView()
        passwordField.placeholder = "Password"
        passwordField.addBottomLine(color: .black.withAlphaComponent(0.5), width: 1.5, bottomAnchor: 6)
        passwordField.isSecureTextEntry = true
        passwordField.font = .systemFont(ofSize: 16)
        return passwordField
    }()
    private var signInButton: UIButton = {
        let signInButton = UIButton.newAutoLayoutView()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = UIColor(named: "purpleColor")
        signInButton.fround(radius: 20)
        return signInButton
    }()
    private var signUpButton: UIButton = {
        let signUpButton = UIButton.newAutoLayoutView()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor(named: "purpleColor"), for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return signUpButton
    }()
    
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        signInButton.addTarget(self, action: #selector(tappedSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
    }
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.fillToSuperview()
        contentView.backgroundColor = .white
        
        contentView.addSubview(welcLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            welcLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            welcLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -10),
            
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descLabel.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -60),
            
            emailField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 60),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func tappedSignIn() {
        guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                print("Email or password field is empty.")
                return
            }
        
        firebaseAuth.signIn(withEmail: email, password: password ) { success, error in
            if ((error?.localizedDescription.contains("email address")) != nil) {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.navigate(NavigationItem(page: .main, navigationStyle: .replace(animated: true)))
        }
    }
    
    @objc func tappedSignUp() {
        self.navigate(NavigationItem(page: .register, navigationStyle: .replace(animated: true)))
    }
}
