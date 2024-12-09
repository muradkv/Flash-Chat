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
    }
    
    //MARK: - Methods
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func handleAuthError(_ error: Error) -> String {
        // Пытаемся привести ошибку к NSError
        guard let nsError = error as NSError?, nsError.domain == AuthErrorDomain else {
            return "Не удалось зарегистрироваться. Попробуйте еще раз (неизвестная ошибка)."
        }
        
        // Извлекаем код ошибки из NSError и обрабатываем ошибку
        guard let authErrorCode = AuthErrorCode(rawValue: nsError.code) else {
            return "Не удалось зарегистрироваться. Неизвестный код ошибки Auth."
        }
        
        switch authErrorCode {
        case .emailAlreadyInUse:
            return "Этот email уже зарегистрирован."
        case .weakPassword:
            return "Пароль должен состоять из не менее 6 символов"
        default:
            return "Не удалось зарегистрироваться. Попробуйте еще раз. Ошибка: \(authErrorCode)"
        }
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
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                let errorMessage = handleAuthError(error!)
                self.showError(message: errorMessage)
                return
            }
            
            let chatVC = ChatViewController()
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
}
