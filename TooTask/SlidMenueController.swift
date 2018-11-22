//
//  ViewControllerSignup.swift
//  SignLogin
//
//  Created by Mohamad on 8/30/18.
//  Copyright © 2018 Mohamad. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SlidMenueController : UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate{
    
    
    @IBOutlet weak var TableMenu: UITableView!
    let SlideMenueItem = ["Setting", "Live Chat" , "Sign out" , "Contact Us"]
    var EmailFormDataBase = ""
    var nameFromDataBase = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TableMenu.delegate = self
        TableMenu.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        TableMenu.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        TableMenu.register(UINib(nibName: "SecoundTableViewCell", bundle: nil), forCellReuseIdentifier: "SecoundTableViewCell")
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SlideMenueItem.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = TableMenu.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            
            cell.PhotoUserProfile.layer.cornerRadius = 10
            cell.PhotoUserProfile.clipsToBounds = true
            
            //  cell.emailUserProfile.text = GIDSignIn.sharedInstance()?.currentUser.profile.email!
            //cell.NameuserProfile.text = GIDSignIn.sharedInstance()?.currentUser.profile.name!
            return cell
            
        }else{
            let cell = TableMenu.dequeueReusableCell(withIdentifier: "SecoundTableViewCell", for: indexPath) as! SecoundTableViewCell
            cell.itemOfAction = SlideMenueItem[indexPath.row - 1]
            cell.ButtonAction.setTitle(SlideMenueItem[indexPath.row - 1],for: .normal)
            cell.Action = {(b) in
                
                if b == "Sign out" {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        GIDSignIn.sharedInstance()?.signOut()
                      // self. navigationController?.popViewController(animated: true)
                       self.dismiss(animated: true, completion: nil)
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    
                }else if b == "Live Chat"  {
                    self.performSegue(withIdentifier: "LiveChat", sender: nil)
                }
                
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func dissmis2(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
