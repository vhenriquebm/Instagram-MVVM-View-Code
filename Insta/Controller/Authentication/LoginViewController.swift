//
//  LoginViewController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 19/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "Instagram_logo_white")
        return image
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.attributedPlaceholder =  NSAttributedString(string: "e-mail", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .default
        tf.setHeight(50)
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.attributedPlaceholder =  NSAttributedString(string: "senha", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.isSecureTextEntry = true
        
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
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return button
        
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        
        let button = UIButton(type: .system)
      
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        
        let attributedTittle = NSMutableAttributedString(string: "ainda não tem uma conta?  ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTittle.append(NSAttributedString(string: "Cadastre-se", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTittle, for: .normal)

        return button
        
    }()
    
    
    private lazy var forgotPasswordButton: UIButton = {
        
        let button = UIButton(type: .system)
      
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        
        let attributedTittle = NSMutableAttributedString(string: "Esqueçeu sua senha?  ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTittle.append(NSAttributedString(string: "Recupere aqui", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTittle, for: .normal)

        return button
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
    }
    
    
    
    
    //MARK: - Private methods
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        gradientColor()
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
    
    private func gradientColor() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    
}
