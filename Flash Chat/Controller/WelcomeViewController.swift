//
//  ViewController.swift
//  Flash Chat
//
//  Created by murad on 05.12.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let welcomeView = WelcomeView()
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.delegate = self 
    }


}

extension WelcomeViewController: WelcomeViewDelegate {
    func didLoginButtonTapped(_ sender: UIButton) {
        let dest = AuthViewController(authType: .login)
        navigationController?.pushViewController(dest, animated: true)
    }
    
    func didRegisterButtonTapped(_ sender: UIButton) {
        let dest = AuthViewController(authType: .register)
        navigationController?.pushViewController(dest, animated: true)
    }
}
