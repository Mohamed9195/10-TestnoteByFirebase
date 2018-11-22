//
//  SecoundTableViewCell.swift
//  TooTask
//
//  Created by mohamed hashem on 11/21/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit

class SecoundTableViewCell: UITableViewCell {
   
    @IBOutlet weak var ButtonAction: UIButton!
    var Action : ((String)->())?
    var itemOfAction = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //ButtonAction.titleLabel?.text! = itemOfAction
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func PressedAction(_ sender: UIButton) {
        Action?(itemOfAction)
        
       
    }
}
