//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by murad on 05.12.2024.
//

import UIKit

class WelcomeView: UIView {
    
    //MARK: - Properties
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .brandLightBlue
        button.setTitleColor(.tintColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⚡️ Flash Chat"
        label.font = UIFont.systemFont(ofSize: 50, weight: .black)
        label.textAlignment = .center
        label.textColor = .brandBlue
        return label
    }()
        
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupView() {
        backgroundColor = .systemBackground

        [titleLabel, registerButton, loginButton].forEach { view in
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200),
            
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20)
        ])
    }
    
    private func setupButton() {
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func registerTapped() {
        print("register tapped")
    }
    
    @objc private func loginTapped() {
        print("login tapped")
    }
}
