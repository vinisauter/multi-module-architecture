//
//  HomeViewController.swift
//  Home
//
//  Created by Felippe Matos on 09/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    private var profileButton: UIButton = UIButton()
    private var logoutButton: UIButton = UIButton()
    
    let viewModel: HomeViewModelProtocol
    let delegate: HomeNavigationDelegate?
    
    public init(viewModel: HomeViewModelProtocol, delegate: HomeNavigationDelegate?) {
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
        
        self.profileButton.addTarget(self, action: #selector(self.onClickProfile), for: .touchUpInside)
        self.logoutButton.addTarget(self, action: #selector(self.onClickLogout), for: .touchUpInside)
    }
}

// MARK: Action
extension HomeViewController {
    @objc func onClickProfile(sender: UIButton) {
        HomeLauncher.shared.finish(start: .Profile, delegate: delegate)
    }
    
    @objc func onClickLogout(sender: UIButton) {
        HomeLauncher.shared.finish(start: .Login, delegate: delegate)
    }
}

// MARK: Navigation

// MARK: UI
extension HomeViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.95)
        self.navigationController?.title = self.viewModel.getUserName()
        
        self.profileButton.setTitle("PROFILE", for: .normal)
        self.profileButton.setTitleColor(.white, for: .normal)
        self.profileButton.backgroundColor = .black
        
        self.logoutButton.setTitle("LOGOUT", for: .normal)
        self.logoutButton.setTitleColor(.black, for: .normal)
        self.logoutButton.backgroundColor = .white
        
        view.addSubview(self.profileButton)
        view.addSubview(self.logoutButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var verticalConstraint = profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        var widthConstraint = profileButton.widthAnchor.constraint(equalToConstant: 300)
        var heightConstraint = profileButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60)
        widthConstraint = logoutButton.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = logoutButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}
