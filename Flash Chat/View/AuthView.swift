//
//  RegisterView.swift
//  Flash Chat
//
//  Created by murad on 06.12.2024.
//

import UIKit

enum AuthType {
    case login
    case register
    
    var buttonTitle: String {
        switch self {
        case .login:
            return "Login"
        case .register:
            return "Register"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .login:
            return UIColor(red: 42 / 255, green: 199 / 255, blue: 254 / 255, alpha: 1)
        case .register:
            return .brandLightBlue
        }
    }
}

protocol AuthViewDelegate: AnyObject {
    func didActionButtonTapped(_ sender: UIButton, emailText: UITextField, passwordText: UITextField)
}

class AuthView: UIView {
    
    //MARK: - Properties
    
    private let areaTextFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.textColor = .brandBlue
        textField.returnKeyType = .go
        textField.autocapitalizationType = .words
        
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = false
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        
        return textField
    }()
    
    private let passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.textColor = .brandBlue
        textField.returnKeyType = .go
        textField.autocapitalizationType = .words
        textField.isSecureTextEntry = true
        
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = false
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        
        return textField
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandLightBlue
        button.setTitleColor(.tintColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        return button
    }()
    
    weak var delegate: AuthViewDelegate?
    var authType = AuthType.login
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(authType: AuthType) {
        self.init()
        self.authType = authType
        setupView(authType: authType)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupView(authType: AuthType) {
        backgroundColor = authType.backgroundColor
        actionButton.setTitle(authType.buttonTitle, for: .normal)
        
        [areaTextFieldView, actionButton].forEach { view in
            addSubview(view)
        }
        
        areaTextFieldView.addSubview(emailTextfield)
        areaTextFieldView.addSubview(passwordTextfield)
        
        NSLayoutConstraint.activate([
            areaTextFieldView.centerXAnchor.constraint(equalTo: centerXAnchor),
            areaTextFieldView.centerYAnchor.constraint(equalTo: centerYAnchor),
            areaTextFieldView.heightAnchor.constraint(equalToConstant: 150),
            areaTextFieldView.widthAnchor.constraint(equalToConstant: 400),
            
            emailTextfield.topAnchor.constraint(equalTo: areaTextFieldView.topAnchor, constant: 20),
            emailTextfield.centerXAnchor.constraint(equalTo: areaTextFieldView.centerXAnchor),
            emailTextfield.heightAnchor.constraint(equalToConstant: 45),
            emailTextfield.leadingAnchor.constraint(equalTo: areaTextFieldView.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: areaTextFieldView.trailingAnchor, constant: -20),
            
            passwordTextfield.bottomAnchor.constraint(equalTo: areaTextFieldView.bottomAnchor, constant: -20),
            passwordTextfield.centerXAnchor.constraint(equalTo: areaTextFieldView.centerXAnchor),
            passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),
            passwordTextfield.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            passwordTextfield.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            
            actionButton.topAnchor.constraint(equalTo: areaTextFieldView.bottomAnchor, constant: 30),
            actionButton.heightAnchor.constraint(equalToConstant: 60),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
    
    private func setupButton() {
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
    }
    
    @objc private func actionTapped() {
        print("action tapped")
        delegate?.didActionButtonTapped(actionButton, emailText: emailTextfield, passwordText: passwordTextfield)
    }
}
