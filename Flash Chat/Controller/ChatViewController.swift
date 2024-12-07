//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by murad on 07.12.2024.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    
    let chatView = ChatView()
    
    //MARK: - Life cycle
    
    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
