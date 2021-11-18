//
//  ProfileViewController.swift
//  Profile
//
//  Created by Felippe Matos on 09/11/21.
//

import UIKit

class ProfileViewController: UIViewController {
    private var userNameLabel: UILabel = UILabel()
    private var logoutButton: UIButton = UIButton()
    private var userImageView: UIImageView = UIImageView()
    
    let viewModel: ProfileViewModelProtocol
    let delegate: ProfileNavigationDelegate?
    
    public init(viewModel: ProfileViewModelProtocol, delegate: ProfileNavigationDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("******* \(type(of: self))")
        
        setupUI()
        
        self.logoutButton.addTarget(self, action: #selector(self.onClickLogout), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.95)
        
        self.userImageView.image = UIImage(named: "avatar")
        self.userImageView.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.85)
        
        self.userNameLabel.text = viewModel.getUserName()
        self.userNameLabel.textAlignment = .center
        self.userNameLabel.textColor = .black
        
        self.logoutButton.setTitle("LOGOUT", for: .normal)
        self.logoutButton.setTitleColor(.white, for: .normal)
        self.logoutButton.backgroundColor = .black
        
        view.addSubview(self.userImageView)
        view.addSubview(self.userNameLabel)
        view.addSubview(self.logoutButton)
        
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = self.userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var verticalConstraint = self.userImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        var widthConstraint = self.userImageView.widthAnchor.constraint(equalToConstant: 100)
        var heightConstraint = self.userImageView.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = self.userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = self.userNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:0)
        widthConstraint = self.userNameLabel.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = self.userNameLabel.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.logoutButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = self.logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = self.logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        widthConstraint = self.logoutButton.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = self.logoutButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

// MARK: Action
extension ProfileViewController {
    @objc func onClickLogout(sender: UIButton) {
        ProfileLauncher.shared.finish(delegate: delegate)
    }
}
