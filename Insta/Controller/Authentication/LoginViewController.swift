//
//  LoginViewController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 19/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    private var viewModel = LoginViewModel()
    
    //MARK: - Properties
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "Instagram_logo_white")
        return image
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "senha")
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no

        return tf
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "ainda não tem uma conta?  ", secondPart: "Cadastre-se")
        button.addTarget(self, action: #selector(presentRegisterController), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Esqueçeu sua senha?  ", secondPart: "Recupere aqui")
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
        configureNotificationsObservers()
    }
    
    //MARK: - Private methods
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        configureGradientLayer()
        navigationController?.navigationBar.barStyle = .black
        addSubViews()
        configureConstraints()
        
    }
    
    private func addSubViews() {
        view.addSubview(logoImage)
        view.addSubview(stack)
        view.addSubview(dontHaveAccountButton)
    }
    
    private func configureConstraints () {
        logoImage.centerX(inView: view)
        logoImage.setDimensions(height: 80, width: 120)
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    

    @objc private func presentRegisterController () {
    let controller = RegisterViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureNotificationsObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
            
        } else {
            viewModel.password = sender.text
        }
        
        loginButton.backgroundColor = viewModel.buttonBackGroundColor
        loginButton.setTitleColor(viewModel.buttonTittleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
    
}
