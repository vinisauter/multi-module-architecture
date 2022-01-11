//
//  ProfileHomeViewController.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

open class ProfileHomeViewController: BaseViewController<ProfileHomeViewModelProtocol> {
    // MARK: - Private Properties
    
    private let goToHomeButton: UIButton = UIButton()
    private let callLoginButton: UIButton = UIButton()
    private let goToForgotPasswordButton: UIButton = UIButton()
    
    // MARK: - Life Cycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    // MARK: - Setup Functions
    
    private func setupUI() {
        setupView()
        setupButton()
    }
    
    private func setupView() {
        view.backgroundColor = .purple
        title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(goToHome))
    }
    
    private func setupButton() {
        goToHomeButton.setTitle("Go to Home", for: .normal)
        goToHomeButton.setTitleColor(.red, for: .normal)
        goToHomeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        goToHomeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goToHomeButton)
        
        goToHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goToHomeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        callLoginButton.setTitle("Call Login", for: .normal)
        callLoginButton.setTitleColor(.red, for: .normal)
        callLoginButton.addTarget(self, action: #selector(callLogin), for: .touchUpInside)
        
        callLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(callLoginButton)
        
        callLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callLoginButton.topAnchor.constraint(equalTo: goToHomeButton.bottomAnchor, constant: 16.0).isActive = true
        
        goToForgotPasswordButton.setTitle("Go to Forgot Password", for: .normal)
        goToForgotPasswordButton.setTitleColor(.red, for: .normal)
        goToForgotPasswordButton.addTarget(self, action: #selector(goToForgotPassword), for: .touchUpInside)
        
        goToForgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goToForgotPasswordButton)
        
        goToForgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goToForgotPasswordButton.topAnchor.constraint(equalTo: callLoginButton.bottomAnchor, constant: 16.0).isActive = true
    }
    
    // MARK: - Private Functions
    
    @objc private func goToHome() {
        viewModel?.goToHome(in: self)
    }
    
    @objc private func callLogin() {
        viewModel?.callLogin(in: self)
    }
    
    @objc private func goToForgotPassword() {
        viewModel?.goToForgotPassword(in: self)
    }
}
