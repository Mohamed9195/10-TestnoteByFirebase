//
//  Message.swift
//  TooTask
//
//  Created by mohamed hashem on 11/21/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import Foundation
class Message {
    
    //TODO: Messages need a messageBody and a sender variable
    
    var senderEmail: String 
    var messageBody: String  = ""
    var TimeDate:    Date  = Date()
  
    init() {
        senderEmail = "TooDo Apps"
    }
}
