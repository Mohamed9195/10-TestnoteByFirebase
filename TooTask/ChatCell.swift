//
//  ChatCell.swift
//  TooTask
//
//  Created by mohamed hashem on 11/21/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var UserProfilePhoto: UIImageView!
    @IBOutlet weak var useName: UILabel!
    @IBOutlet weak var userMessage: UILabel!
    
    @IBOutlet weak var ggggg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
