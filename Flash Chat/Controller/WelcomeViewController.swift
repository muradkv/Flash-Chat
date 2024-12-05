//
//  ViewController.swift
//  Flash Chat
//
//  Created by murad on 05.12.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = .systemBackground
    }


}

