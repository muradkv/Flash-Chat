//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by murad on 06.12.2024.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController {
    
    //MARK: - Properties
    
    private let authView: AuthView
    
    // MARK: - Initialization
    
    init(authType: AuthType) {
        self.authView = AuthView(authType: authType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.delegate = self
        configureNavBar()
    }
    
    //MARK: - Methods
    
    private func configureNavBar() {
        if authView.authType == .login {
            navigationController?.navigationBar.tintColor = .white
        } else {
            navigationController?.navigationBar.tintColor = .blue
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AuthViewController: AuthViewDelegate {
    func didActionButtonTapped(_ sender: UIButton, emailText: UITextField, passwordText: UITextField) {
        
        guard let email = emailText.text,
              let password = passwordText.text,
              !email.isEmpty,
              !password.isEmpty
        else {
            showError(message: "Пожалуйста, заполните все поля.")
            return
        }
        
        if let register = sender.titleLabel?.text, register == "Register" {
            AuthService.shared.registerUser(email: email, password: password) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    let chatVC = ChatViewController()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                case .failure(let error):
                    let errorMessage = AuthService.shared.handleAuthError(error)
                    self.showError(message: errorMessage)
                }
            }
        } else {
            AuthService.shared.loginUser(email: email, password: password) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success():
                    let chatVC = ChatViewController()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                case .failure(let error):
                    let errorMessage = AuthService.shared.handleAuthError(error)
                    self.showError(message: errorMessage)
                }
            }
        }
    }
}
