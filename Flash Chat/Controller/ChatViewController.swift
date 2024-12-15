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
                }
            }
        }
    }
    
    func didSendButtonTapped(_ sender: UIButton, text: UITextField) {
        if let messageBody = text.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("There was an issue saving data. \(e)")
                } else {
                    print("Successfully saved data")
                }
            }
            
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
