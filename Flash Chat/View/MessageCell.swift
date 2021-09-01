//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Fernando González on 30/08/21.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var bubbleViewMessage: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    // This method is called when a new row is created on a tableView
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // We need a form of bubble. To get the height bubbleViewMessage.frame.size.height
        bubbleViewMessage.layer.cornerRadius = bubbleViewMessage.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
