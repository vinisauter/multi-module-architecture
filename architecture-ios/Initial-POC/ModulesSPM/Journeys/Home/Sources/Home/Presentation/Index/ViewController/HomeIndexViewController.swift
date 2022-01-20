//
//  HomeViewController.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

open class HomeIndexViewController: BaseViewController<HomeIndexViewModelProtocol> {
    // MARK: - Private Properties
    
    private let button: UIButton = UIButton()
    private let logoutButton: UIButton = UIButton()
    
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
    }
    
    private func setupView() {
        view.backgroundColor = .red
        title = "Home"
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupButton() {
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Open Profile", for: .normal)
        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16.0).isActive = true

    }
    
    // MARK: - Private Functions
    
    @objc private func openProfile() {
        viewModel?.openProfile(in: self)
    }
    
    @objc private func logout() {
        viewModel?.logout(in: self)
    }
    
}
