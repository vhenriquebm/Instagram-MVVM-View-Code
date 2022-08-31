//
//  RegisterViewController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 19/08/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: AuthenticationDelegate?
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        configureUI()
        configureNotificationsObservers()
    }
    
    // MARK: - Properties
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action:#selector(plusButtonDidSelected), for: .touchUpInside)
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
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        button.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
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
    
    func configureNotificationsObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        
        else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            
            viewModel.fullName = sender.text
        } else {
            
            viewModel.userName = sender.text

        }
        
        updateForm()
        
    }
    
    @objc private func plusButtonDidSelected () {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    @objc private func createNewUser () {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text, let userName = userNameTextField.text?.lowercased(), let profileImage = self.profileImage else {return}
        
        let credentials =  AuthCredentials(email: email, password: password, fullname: fullName, username: userName, profileImage: profileImage)
        
        
        print ("As credenciais são \(credentials)")
        
        Authservice.registerUserWith(credentials: credentials) { error in
            
            if let error = error {
                print ("DEBUG: failed to register user \(error.localizedDescription)")
            }
            
            self.delegate?.authenticationComplete()
            self.dismiss(animated: true)
            print ("Successfully registered user with Firestore")
        }
        
    }
    
    
}

//MARK: - FormViewModel

extension RegisterViewController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackGroundColor
        signUpButton.setTitleColor(viewModel.buttonTittleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}


//MARK: - UIImagePickerControllerDelegate


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true)
    }
}
