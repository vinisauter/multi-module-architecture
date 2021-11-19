//
//  EditProfileViewController.swift
//  Profile
//
//  Created by Felippe Matos on 18/11/21.
//

import UIKit

class EditProfileViewController: UIViewController {
    private var saveButton: UIButton = UIButton()
    
    let viewModel: EditProfileViewModelProtocol
    
    public init(viewModel: EditProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.saveButton.addTarget(self, action: #selector(self.onClick), for: .touchUpInside)
    }
}

// MARK: Action
extension EditProfileViewController {
    @objc func onClick(sender: UIButton) {
        print(viewModel.save())
        navigationController?.popViewController(animated: false)
    }
}

// MARK: Navigation

// MARK: UI
extension EditProfileViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.95)
        
        self.saveButton.setTitle("SALVAR ALTERAÇÕES", for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.backgroundColor = .black
        
        view.addSubview(self.saveButton)
        
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = self.saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
        let widthConstraint = self.saveButton.widthAnchor.constraint(equalToConstant: 300)
        let heightConstraint = self.saveButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
    }
}
