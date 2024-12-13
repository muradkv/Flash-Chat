//
//  ChatView.swift
//  Flash Chat
//
//  Created by murad on 06.12.2024.
//
import UIKit

class ChatView: UIView {
    
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MessageCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandPurple
        return view
    }()
    
    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write a message..."
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.textColor = .brandPurple
        textField.returnKeyType = .send
        textField.autocapitalizationType = .sentences
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .brandLightPurple
        return button
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupView() {
        backgroundColor = .brandPurple
        
        [tableView, bottomContainerView].forEach { view in
            addSubview(view)
        }
        
        bottomContainerView.addSubview(messageTextField)
        bottomContainerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            bottomContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            sendButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20),
            sendButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            
            messageTextField.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 20),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            messageTextField.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
        ])
    }
    
    private func setupButton() {
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
    }
    
    @objc private func sendTapped() {
        print("send tapped")
    }
    
    func setTableViewDelegate(_ delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
    
    func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
}
