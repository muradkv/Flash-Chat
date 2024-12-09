//
//  AuthService.swift
//  Flash Chat
//
//  Created by murad on 09.12.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func handleAuthError(_ error: Error) -> String {
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
