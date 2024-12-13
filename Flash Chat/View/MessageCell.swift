//
//  MessageCell.swift
//  Flash Chat
//
//  Created by murad on 11.12.2024.
//

import UIKit

final class MessageCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let horizStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MeAvatar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "YouAvatar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageBubble: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandPurple
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let messageText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .brandLightPurple
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupView() {
        contentView.addSubview(horizStackView)
        [leftImageView, messageBubble, rightImageView].forEach { view in
            horizStackView.addArrangedSubview(view)
        }
        messageBubble.addSubview(messageText)
                
        NSLayoutConstraint.activate([
            horizStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            horizStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            horizStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            leftImageView.heightAnchor.constraint(equalToConstant: 40),
            leftImageView.widthAnchor.constraint(equalToConstant: 40),
            
            messageText.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 5),
            messageText.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -5),
            messageText.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 10),
            messageText.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -10),
            
            rightImageView.heightAnchor.constraint(equalToConstant: 40),
            rightImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configure(text: String) {
        messageText.text = text
    }
    
    func configureTable() {
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }
}
