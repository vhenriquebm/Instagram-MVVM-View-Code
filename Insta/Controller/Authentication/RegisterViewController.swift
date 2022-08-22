//
//  RegisterViewController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 19/08/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - Properties
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "senha")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var fullNameTextField = CustomTextField(placeholder: "nome completo")

    
    private lazy var userNameTextField = CustomTextField(placeholder: "nome do usuário")
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Já tenho uma conta  ", secondPart: "Voltar")
        button.addTarget(self, action: #selector(presentLoginController), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Private methods
    private func configureUI() {
        configureGradientLayer()
        addSubViews()
        configureConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(plusPhotoButton)
        view.addSubview(stack)
        view.addSubview(alreadyHaveAccountButton)
    }
    
    private func configureConstraints() {
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
       
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom:view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    
    @objc private func presentLoginController () {
        
        navigationController?.popViewController(animated: true)
    }
}
