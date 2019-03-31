//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by murad on 30/03/2019.
//  Copyright © 2019 murad. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    @IBOutlet weak var senderUserName: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
