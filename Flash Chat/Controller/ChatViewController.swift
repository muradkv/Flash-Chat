//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by murad on 07.12.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ChatViewController: UIViewController, ChatViewDelegate {
    
    //MARK: - Properties
    
    private let chatView = ChatView()
    private var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hello moto moto"),
        Message(sender: "1@3.com", body: "Oh yes is it you. А теперь перейдем на русский малышка. Знаешь что? пАшел вон такая гхад"),
        Message(sender: "1@1.com", body: "Makhachkala")
    ]
    
    let db = Firestore.firestore()
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItem()
        chatView.setTableViewDelegate(self)
        chatView.setTableViewDataSource(self)
        chatView.delegate = self
        chatView.setTextFieldDelegate(self)
        loadMessages()
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
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25, weight: .black),
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationController?.navigationBar.barTintColor = .brandPurple
    }
    
    @objc func barButtonTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            guard error == nil else {
                print("There was an issue retrieving data from Firestore. \(String(describing: error))")
                return
            }
            
            guard let snapshotDocuments = querySnapshot?.documents else {
                return
            }
            
            for doc in snapshotDocuments {
                let doc = doc.data()
                
                guard let sender = doc[K.FStore.senderField] as? String,
                      let messageBody = doc[K.FStore.bodyField] as? String
                else { return }
                
                let newMessage = Message(sender: sender, body: messageBody)
                self.messages.append(newMessage)
                
                DispatchQueue.main.async {
                    self.chatView.tableViewReload()
                    self.scrollToBottom()
                }
            }
        }
    }
    
    private func scrollToBottom() {
        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
        self.chatView.scrollTo(indexPath: indexPath)
    }
    
    func didSendButtonTapped(_ sender: UIButton, textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        sendMessage(text: text) { success in
            if success {
                textField.text = ""
                textField.endEditing(true)
            }
        }
    }
    
    private func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let messageSender = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }
        
        let data: [String: Any] = [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: text,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]
        
        db.collection(K.FStore.collectionName).addDocument(data: data) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Successfully saved data")
                completion(true)
            }
        }
    }
}

//MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        
        sendMessage(text: text) { success in
            if success {
                textField.text = ""
                textField.endEditing(true)
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return
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
        
        let message = messages[indexPath.row]
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.stateMessages(from: .me)
        } else {
            cell.stateMessages(from: .anotherSender)
        }
        
        cell.configure(text: messages[indexPath.row].body)
        
        return cell
    }
}
