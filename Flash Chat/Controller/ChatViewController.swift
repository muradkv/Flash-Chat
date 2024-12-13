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
    private let messages: [Message] = [
        Message(sender: "1@2.com", body: "Hello moto moto"),
        Message(sender: "1@3.com", body: "Oh yes is it you. А теперь перейдем на русский малышка. Знаешь что? пАшел вон такая гхад"),
        Message(sender: "1@1.com", body: "Makhachkala")
    ]
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItem()
        chatView.setTableViewDelegate(self)
        chatView.setTableViewDataSource(self)
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

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        
        cell.configure(text: messages[indexPath.row].body)
        
        return cell
    }
}
