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
    
    private let stackView = UIStackView()
    
    // MARK: - Life Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    // MARK: - Setup Functions
    
    private func setupUI() {
        setupView()
        setupStackView()
        setupButton()
    }
    
    private func setupView() {
        view.backgroundColor = .red
        title = "Home"
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupButton() {
        addButton(title: "Open Profile", action: #selector(openProfile))
        addButton(title: "Open Task", action: #selector(openTask))
        addButton(title: "Open Note", action: #selector(openNote))
        
        addButton(title: "Logout", action: #selector(logout))
    }
    
    private func addButton(title: String, action: Selector) {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
    }
    
    // MARK: - Private Functions
    
    @objc private func openProfile() {
        viewModel?.openProfile(in: self)
    }
    
    @objc private func openTask() {
        viewModel?.openTask(in: self)
    }
    
    @objc private func openNote() {
        viewModel?.openNote(in: self)
    }
    
    @objc private func logout() {
        viewModel?.logout(in: self)
    }
    
}
