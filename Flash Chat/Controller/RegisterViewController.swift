//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by murad on 06.12.2024.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    
    private let registerView = AuthView(authType: .login)
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
