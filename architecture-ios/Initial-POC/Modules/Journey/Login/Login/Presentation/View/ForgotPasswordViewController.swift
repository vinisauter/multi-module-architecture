//
//  ForgotPasswordViewController.swift
//  Login
//
//  Created by Felippe Matos on 16/11/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    private var recoveryButton: UIButton = UIButton()
    
    let viewModel: ForgotPasswordViewModelProtocol
    
    public init(viewModel: ForgotPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.recoveryButton.addTarget(self, action: #selector(self.onClick), for: .touchUpInside)
    }
}

// MARK: Action
extension ForgotPasswordViewController {
    @objc func onClick(sender: UIButton) {
        print(viewModel.recoveryPassword())
        navigationController?.popViewController(animated: false)
    }
}

// MARK: Navigation

// MARK: UI
extension ForgotPasswordViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.95)
        
        self.recoveryButton.setTitle("RECUPERAR A SENHA", for: .normal)
        self.recoveryButton.setTitleColor(.white, for: .normal)
        self.recoveryButton.backgroundColor = .black
        
        view.addSubview(self.recoveryButton)
        
        self.recoveryButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.recoveryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = self.recoveryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
        let widthConstraint = self.recoveryButton.widthAnchor.constraint(equalToConstant: 300)
        let heightConstraint = self.recoveryButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
    }
}
