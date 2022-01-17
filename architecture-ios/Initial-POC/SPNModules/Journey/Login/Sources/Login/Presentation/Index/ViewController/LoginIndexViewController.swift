//
//  LoginViewController.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

open class LoginIndexViewController: BaseViewController<LoginIndexViewModelProtocol>  {
    // MARK: - Private Properties
    
    private let button: UIButton = UIButton()
    private let forgotPasswordbutton: UIButton = UIButton()
    private let loadingContainer: UIView = UIView()
    
    // MARK: - Life Cycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    // MARK: - Setup Functions
    
    private func setupUI() {
        setupView()
        setupNavigation()
        setupButton()
        setupLoadingContainer()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Login"
    }
    
    private func setupNavigation() {
        let buttonTitle = isModal ? "Fechar" : "Voltar"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: isModal ? #selector(close) : #selector(back))
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupButton() {
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forgotPasswordbutton.setTitleColor(.blue, for: .normal)
        forgotPasswordbutton.setTitle("Forgot Password", for: .normal)
        forgotPasswordbutton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        
        forgotPasswordbutton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgotPasswordbutton)
        
        forgotPasswordbutton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16.0).isActive = true
        forgotPasswordbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupLoadingContainer() {
        loadingContainer.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        loadingContainer.isHidden = true
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.color = .white

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(activityIndicator)

        activityIndicator.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingContainer)
        
        loadingContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Private Functions
    
    @objc private func login() {
        loadingContainer.isHidden = !loadingContainer.isHidden
        viewModel?.login(with: "nykolas", and: "123456", completion: { [weak self] success in
            guard let self = self else { return }
            self.loadingContainer.isHidden = true
            if success { self.viewModel?.onLoginSuccess(in: self) }
        })
    }
    
    @objc private func forgotPassword() {
        viewModel?.onForgotPasswordClick(in: self)
    }
    
    @objc private func back() {
        viewModel?.onBackClick(in: self)
    }
    
    @objc private func close() {
        viewModel?.onCloseClick(in: self)
    }
}
