//
//  VaquinhaViewController.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core

open class VaquinhaViewController: BaseViewController<VaquinhaViewModelProtocol> {
    
//    let viewModel: VaquinhaViewModelProtocol?
//
//    init(viewModel: VaquinhaViewModelProtocol) {
//        self.viewModel = viewModel
//        super.init()
//    }
//
//    required public init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    // MARK: - Properties
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Profile", for: .normal)
        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
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
    
//    private func setupNavigation() {
//        navigationController?.navigationBar.isHidden = false
//    }
    
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

//open class BaseViewController2: UIViewController {
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required public init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    open func checkDeeplinkIfNeeded() {
//        if let viewModel = viewModel as? BaseViewModelProtocol, let flowDelegate: Deeplinkable = viewModel.getFlow(), viewModel.isIndex {
//            flowDelegate.resolveDeeplinkIfNeeded(from: self)
//        }
//    }
//}

