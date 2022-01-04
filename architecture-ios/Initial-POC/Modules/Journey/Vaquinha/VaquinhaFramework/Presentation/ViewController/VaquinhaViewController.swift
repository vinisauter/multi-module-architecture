//
//  VaquinhaViewController.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core

final class VaquinhaViewController: BaseViewController<VaquinhaViewModelProtocol> {
    
    // MARK: - Properties
   private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Profile", for: .normal)
        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI(){
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .green
        title = "Vaquinha"
    }
    
    private func setupConstraints() {
        view.addSubview(profileButton)
        profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func openProfile() {
        print("Profile screen go to ")
        viewModel?.openProfile(in: self)
    }
}
