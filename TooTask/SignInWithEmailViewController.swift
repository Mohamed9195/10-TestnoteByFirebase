//
//  SignInWithEmailViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 11/13/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInWithEmailViewController: UIViewController {

     let auth = Auth.auth()
    
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func Login(_ sender: UIButton) {
        
        SVProgressHUD.show(withStatus: "loading...")
        auth.signIn(withEmail: emailUser.text!, password: passwordUser.text!) { (Result, error) in
            if error != nil {
                
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Login", message: "Wellcom in Your TooDo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "ShowHomeFromSignIn", sender: self)}))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
}
