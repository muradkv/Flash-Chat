//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by murad on 06.12.2024.
//

import UIKit

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

}

extension AuthViewController: AuthViewDelegate {
    func didActionButtonTapped(_ sender: UIButton) {
        let dest = ChatViewController()
        navigationController?.pushViewController(dest, animated: true)
    }
}
