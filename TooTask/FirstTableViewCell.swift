//
//  FirstTableViewCell.swift
//  TooTask
//
//  Created by mohamed hashem on 11/21/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var PhotoUserProfile: UIImageView!
    @IBOutlet weak var NameuserProfile: UILabel!
    @IBOutlet weak var emailUserProfile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
