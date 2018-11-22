//
//  HomeCollectionViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 11/18/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn



class HomeCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Register cell classes
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        
        collectionView.register(UINib(nibName: "SecoundCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SecoundCollectionViewCell")
        
      
        
        // Do any additional setup after loading the view.
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
            
            return cell0
        }else if indexPath.row == 1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SecoundCollectionViewCell", for: indexPath) as! SecoundCollectionViewCell
            
            cell1.LabelCell.text = "PRIVATE FILE"
            cell1.alpha = 0.7
            return cell1
            
        }else if indexPath.row == 2 {
            let  cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SecoundCollectionViewCell", for: indexPath) as! SecoundCollectionViewCell
            
            cell2.LabelCell.text = "WORLD TOODO"
            cell2.alpha = 0.7
            return cell2
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.alpha = 0.7
            cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            return cell
        }
        // Configure the cell
        
        
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
