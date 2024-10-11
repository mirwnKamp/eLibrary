//
//  RegisterViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/7/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, Coordinator {
    
    private var contentView = UIView.newAutoLayoutView()
    private var descLabel: UILabel = {
        let descLabel = UILabel.newAutoLayoutView()
        descLabel.text = "Create an account to be able\nread your favourite books."
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
    private var signUpButton: UIButton = {
        let signUpButton = UIButton.newAutoLayoutView()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor(named: "purpleColor")
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signUpButton.fround(radius: 20)
        return signUpButton
    }()
    private var signInButton: UIButton = {
        let signInButton = UIButton.newAutoLayoutView()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(UIColor(named: "purpleColor"), for: .normal)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return signInButton
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
        
        contentView.addSubview(descLabel)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descLabel.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -60),
            
            emailField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 60),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func tappedSignUp() {
        guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                print("Email or password field is empty.")
                return
            }
        
        firebaseAuth.createUser(withEmail: email, password: password ) { success, error in
            if ((error?.localizedDescription.contains("email address")) != nil) {
                print(error?.localizedDescription ?? "")
                return
            }
            
            print("Your account created successfully!")
            self.navigate(NavigationItem(page: .main, navigationStyle: .replace(animated: true)))
            
        }
    }
    
    @objc func tappedSignIn() {
        self.navigate(NavigationItem(page: .login, navigationStyle: .replace(animated: true)))
    }
}
