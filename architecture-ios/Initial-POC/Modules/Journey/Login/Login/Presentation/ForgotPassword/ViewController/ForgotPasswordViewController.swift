//
//  ForgotPasswordViewController.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 12/11/21.
//

import UIKit
import Core

open class ForgotPasswordViewController: BaseViewController<ForgotPasswordViewModelProtocol> {
    // MARK: - Private Properties
    private let button: UIButton = UIButton()
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
        title = "Forgot Password"
        view.backgroundColor = .white
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupButton() {
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Change Password", for: .normal)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    @objc private func changePassword() {
        loadingContainer.isHidden = !loadingContainer.isHidden
        viewModel?.changePassword(with: "123456", completion: { [weak self] success in
            guard let self = self else { return }
            self.loadingContainer.isHidden = true
            if success { self.viewModel?.onChangePasswordSuccess(in: self) }
        })
    }
}
