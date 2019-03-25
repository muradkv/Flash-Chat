//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by murad on 24/03/2019.
//  Copyright © 2019 murad. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
    }
    
}
