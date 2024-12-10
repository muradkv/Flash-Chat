//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by murad on 07.12.2024.
//

import UIKit
import FirebaseAuth

final class ChatViewController: UIViewController {
    
    //MARK: - Properties
    
    private let chatView = ChatView()
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - Methods
    
    private func setupBarButtonItem() {
        let logoutBarButton = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(barButtonTapped))
        navigationItem.rightBarButtonItem = logoutBarButton
        
        navigationItem.title = K.appName
    }
    
    @objc func barButtonTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
