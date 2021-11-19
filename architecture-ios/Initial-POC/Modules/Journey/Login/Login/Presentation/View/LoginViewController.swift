//
//  LoginViewController.swift
//  Login
//
//  Created by Felippe Matos on 11/11/21.
//

import UIKit

open class LoginViewController: UIViewController {
    private var cpfTextField: UITextField = UITextField()
    private var passwordTextField: UITextField = UITextField()
    private var loginButton: UIButton = UIButton()
    private var forgotPasswordButton: UIButton = UIButton()
    
    let viewModel: LoginViewModelProtocol
    let delegate: LoginNavigationDelegate?
    
    init(viewModel: LoginViewModelProtocol, delegate: LoginNavigationDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("******* \(type(of: self))")
        
        setupUI()
        
        self.loginButton.addTarget(self, action: #selector(self.onClickLogin), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(self.onClickForgotPassword), for: .touchUpInside)
    }
}

// MARK: Action
extension LoginViewController {
    @objc func onClickLogin(sender: UIButton) {
        let loginSucces = viewModel.login(cpf: self.cpfTextField.text ?? "", password: self.passwordTextField.text ?? "")
        
        if loginSucces {
            print("logou")
            LoginLauncher.shared.finish(delegate: delegate)
        } else {
            print("erro no login")
        }
    }
    
    @objc func onClickForgotPassword(sender: UIButton) {
        goToForgotPasswordScreen()
    }
}

// MARK: Navigation
extension LoginViewController {
    func goToForgotPasswordScreen() {
        let viewModel = ForgotPasswordViewModel(businessModel: self.viewModel.businessModel)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: UI
extension LoginViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 157/255, green: 255/255, blue: 235/255, alpha: 0.95)
        
        self.cpfTextField.placeholder = "CPF"
        self.cpfTextField.textColor = .black
        self.cpfTextField.backgroundColor = .white
        
        self.passwordTextField.placeholder = "PASSWORD"
        self.passwordTextField.textColor = .black
        self.passwordTextField.backgroundColor = .white
        
        self.loginButton.setTitle("LOGIN", for: .normal)
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.backgroundColor = .black
        
        self.forgotPasswordButton.setTitle("Esqueci minha senha", for: .normal)
        self.forgotPasswordButton.setTitleColor(.black, for: .normal)
        self.forgotPasswordButton.backgroundColor = .white
        
        view.addSubview(self.cpfTextField)
        view.addSubview(self.passwordTextField)
        view.addSubview(self.loginButton)
        view.addSubview(self.forgotPasswordButton)

        self.cpfTextField.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = self.cpfTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var verticalConstraint = self.cpfTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        var widthConstraint = self.cpfTextField.widthAnchor.constraint(equalToConstant: 300)
        var heightConstraint = self.cpfTextField.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = self.passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = self.passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90)
        widthConstraint = self.passwordTextField.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = self.loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = self.loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200)
        widthConstraint = self.loginButton.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = self.loginButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = self.forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        verticalConstraint = self.forgotPasswordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 260)
        widthConstraint = self.forgotPasswordButton.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
    }
}


