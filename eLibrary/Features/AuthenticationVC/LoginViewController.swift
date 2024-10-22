//
//  LoginViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 19/7/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Coordinator, AlertPresentableVC {
    
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
    private var emailErrorLabel: UILabel = {
        let emailErrorLabel = UILabel.newAutoLayoutView()
        emailErrorLabel.textColor = .red
        emailErrorLabel.font = .systemFont(ofSize: 12)
        emailErrorLabel.isHidden = true
        return emailErrorLabel
    }()
    private var passwordField: UITextField = {
        let passwordField = UITextField.newAutoLayoutView()
        passwordField.placeholder = "Password"
        passwordField.addBottomLine(color: .black.withAlphaComponent(0.5), width: 1.5, bottomAnchor: 6)
        passwordField.isSecureTextEntry = true
        passwordField.font = .systemFont(ofSize: 16)
        return passwordField
    }()
    private var passwordErrorLabel: UILabel = {
        let passwordErrorLabel = UILabel.newAutoLayoutView()
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.font = .systemFont(ofSize: 12)
        passwordErrorLabel.isHidden = true
        return passwordErrorLabel
    }()
    private var signInButton: UIButton = {
        let signInButton = UIButton.newAutoLayoutView()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = .purpleCustom
        signInButton.fround(radius: 20)
        return signInButton
    }()
    private var signUpButton: UIButton = {
        let signUpButton = UIButton.newAutoLayoutView()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.purpleCustom, for: .normal)
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
 
    // MARK: - UI
    func setupUI() {
        view.addSubview(contentView)
        contentView.fillToSuperview()
        contentView.backgroundColor = .white
        
        contentView.addSubview(welcLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(emailField)
        contentView.addSubview(emailErrorLabel)
        contentView.addSubview(passwordField)
        contentView.addSubview(passwordErrorLabel)
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
            
            emailErrorLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            
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
    
    //MARK: - Buttons Interact
    @objc func tappedSignIn() {
        guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                print("Email or password field is empty.")
                return
            }
        
        firebaseAuth.signIn(withEmail: email, password: password ) { [weak self] success, error in
            guard let self = self else { return }
            if let error, error.localizedDescription.contains("email address") {
                self.presentAlert(.emailFormatError(title: "Oops!", description: error.localizedDescription, actionAfterHide: {}))
                return
            } else if let error {
                self.presentAlert(.credsError(title: "Oops!", description: "Your email or password are not correct. If you don't have an account please create a new one!", actionAfterHide: {}, action: {
                    self.navigate(.init(page: .register, navigationStyle: .replace(animated: true)))
                }))
                return
            }
            
            self.navigate(NavigationItem(page: .main, navigationStyle: .replace(animated: true)))
        }
    }
    
    @objc func tappedSignUp() {
        self.navigate(NavigationItem(page: .register, navigationStyle: .replace(animated: true)))
    }
}
