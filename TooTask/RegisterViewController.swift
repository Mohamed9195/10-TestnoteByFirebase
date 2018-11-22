//
//  RegisterViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 11/13/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    @IBOutlet weak var retpassowrdUser: UITextField!
    
    let pickerTackPhoto = UIImagePickerController()
    let pickerOpenGalary = UIImagePickerController()
    
    let auth = Auth.auth()
    let database = Database.database()
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.photoUser.layer.cornerRadius = self.photoUser.frame.size.width / 2
        self.photoUser.clipsToBounds = true
    }
    
    
    //MARK: - PikerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageTaken = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        photoUser.image = imageTaken
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - open galary
    @IBAction func OpenGalary(_ sender: UIBarButtonItem) {
        pickerOpenGalary.delegate = self
        pickerOpenGalary.allowsEditing = false
        pickerOpenGalary.sourceType = .photoLibrary
        present(pickerOpenGalary, animated: true, completion: nil)
    }
    
    //MARK: - open camera
    @IBAction func AddPhoto(_ sender: UIBarButtonItem) {
        pickerTackPhoto.delegate = self
        pickerTackPhoto.allowsEditing = false
        pickerTackPhoto.sourceType = .camera
        present(pickerTackPhoto, animated: true, completion: nil)
    }
    
    //MARK: - register
    @IBAction func Register(_ sender: UIButton) {
        
        SVProgressHUD.show(withStatus: "loading....")
        
        if CheckPassword(Pasword: passwordUser.text!, RETPassword: retpassowrdUser.text!) != true {
            let alert = UIAlertController(title: "Error", message: "password not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        auth.createUser(withEmail: emailUser.text!, password: passwordUser.text!) { (Result, error) in
            if error != nil {
                
                
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }else{
                
                let DataToFirebase = [
                    "Email" : self.emailUser.text!,
                    "Password": self.passwordUser.text!,
                    "Name": self.nameUser.text!
                ]
                
                guard let AuthEmail = self.auth.currentUser?.uid else {return}
                self.database.reference(withPath: "Personal-Data").child("users/data/\(self.nameUser.text!)/\(AuthEmail)").childByAutoId().setValue(DataToFirebase){ (error , refernce) in
                    if error != nil {
                        
                        SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else {
                        
                    }
                    
                }
                
                
                self.uploadPhotoToFirebase()
                
                
            }
            
            
        }
        
    }
    
    
    
    //MARK: - Chike upload photo
    func uploadPhotoToFirebase(){
        
        let storage = Storage.storage()
        let FileUploadData =  photoUser.image!.pngData()
        
        storage.reference(withPath: "Personal-Data").child("images/\(auth.currentUser!.uid)").putData(FileUploadData!, metadata: nil){ (metadata, error) in
            guard metadata != nil else {
                return
            }
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Register", message: "Wellcom in Your TooDo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { (UIAlertAction) in
                self.performSegue(withIdentifier: "ShowHomeFromRegister", sender: self)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Chick password
    func CheckPassword(Pasword: String , RETPassword: String)-> Bool {
        var ResultCheck = false
        if Pasword == RETPassword {
            ResultCheck = true
            return ResultCheck
        }else{
            ResultCheck = false
            return ResultCheck
        }
    }
    
    
    
}
