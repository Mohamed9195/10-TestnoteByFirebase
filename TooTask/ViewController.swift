//
//  ViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 10/30/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import GoogleSignIn


class ViewController: UIViewController , GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
    // Configer notfication
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge , .sound ]) { (didAllow, error) in }
        
        
        if Auth.auth().currentUser?.uid != nil || GIDSignIn.sharedInstance()?.hasAuthInKeychain() == true{
            performSegue(withIdentifier: "ShowHomeFromBegining", sender: self)
        }
        
        
    }

    
    
    @IBAction func LoginByGoogle(_ sender: UIButton) {
        
       
        
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            
            let alert = UIAlertController(title: "Login", message: "you are login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: {  (UIAlertAction) in
                self.performSegue(withIdentifier: "ShowHomeFromBegining", sender: self)}))
            present(alert, animated: true, completion: nil)
           
            
        }else {
           
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
         
            //  viewToGoogle.style = GIDSignInButtonStyle.wide
        }
        
        
    }
    
    
}

