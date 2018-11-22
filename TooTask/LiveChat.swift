//
//  LiveChat.swift
//  TooTask
//
//  Created by mohamed hashem on 11/21/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LiveChat: UIViewController , UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate{
    
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var sendButoon: UIButton!
    
    var ListOfMessage : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chatTable.delegate = self
        chatTable.dataSource = self
        
        chatTable.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
       
        retriveMessages()
        chatTable.separatorStyle = .none
        chatTable.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListOfMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.useName.text = ListOfMessage[indexPath.row].senderEmail
        cell.userMessage.text = ListOfMessage[indexPath.row].messageBody
        if Auth.auth().currentUser?.email == "dev@dev.com" {
            cell.UserProfilePhoto.image = UIImage(named: "")
        }
        return cell
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        textMessage.isEnabled = false
        sendButoon.isEnabled = false
        if (textMessage.text?.isEmpty)! {
            let alert = UIAlertController(title: "Error", message: "Enter value first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
        let messageToFirebase = Database.database().reference(withPath: "MessageFromUsers").child("Message/\(Auth.auth().currentUser?.uid ?? "user")")
        
        let messageDictionary = ["sender": Auth.auth().currentUser?.email , "MessageBody": textMessage.text! ]
        
        messageToFirebase.childByAutoId().setValue(messageDictionary) { (error, DatabaseReference) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.textMessage.isEnabled = true
                self.sendButoon.isEnabled = true
                self.textMessage.text = ""
            }
        }
        }
        
    }
    
    
    func retriveMessages() {
        
        let messageToFirebase = Database.database().reference(withPath: "MessageFromUsers").child("Message/\(Auth.auth().currentUser?.uid ?? "user")")
        
        messageToFirebase.observe(.childAdded ,  with: { (DataSnapshot) in
            let snapshotValue = DataSnapshot.value as! Dictionary<String, String>
            
            let messageToList = Message()
            messageToList.messageBody = snapshotValue["MessageBody"]!
            messageToList.senderEmail = snapshotValue["sender"]!
            
            self.ListOfMessage.append(messageToList)
            
            self.chatTable.reloadData()
            
        })
        
    }
    
    @IBAction func Deletemessage(_ sender: UIBarButtonItem) {
    }
    
}
