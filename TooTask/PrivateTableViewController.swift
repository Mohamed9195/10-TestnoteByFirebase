//
//  PrivateTableViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 11/22/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import  CoreData

class PrivateTableViewController: UITableViewController {
    
    let DefaultUserPassword = UserDefaults.standard
    
    @IBOutlet weak var lock_unlock: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var DataFromCategorySecrit: [SecretCategory] = []
    var path = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        
        if DefaultUserPassword.string(forKey: "password")! == "" {
            lock_unlock.title = "Lock"
            view.isHidden = false
            
            
        }else{
             lock_unlock.title = "UnLock"
             view.isHidden = true
            print("jjjjjjjjjjjjj")
        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let longPressgester = UILongPressGestureRecognizer(target: self, action: #selector(editCategory))
        tableView.addGestureRecognizer(longPressgester)
        
        LoadData()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataFromCategorySecrit.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = DataFromCategorySecrit[indexPath.row].nameOfSecrit
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 || indexPath.row == 1  || indexPath.row == 2 {
            return false
        }else{
            return true
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        path = indexPath.row
         performSegue(withIdentifier: "goToInfoPrivate", sender: self)
        
    }
    
     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToInfoPrivate" {
            let destinationVC = segue.destination as! InfoPrivateViewController
            destinationVC.SelectedInfo = DataFromCategorySecrit[path]
        }
        
    }
 
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            context.delete(DataFromCategorySecrit[indexPath.row])
            DataFromCategorySecrit.remove(at: indexPath.row)
            save()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - loade Data
    func  LoadData(With request: NSFetchRequest<SecretCategory> = SecretCategory.fetchRequest()) {
        do{
            DataFromCategorySecrit = try context.fetch(request)
        }catch{
            fatalError("Error in reading data : \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK: - Save data
    func save(){
        do{
            try context.save()
            
        }catch{
            
            fatalError("Error in saving data: \(error)")
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Add data
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        
        var textCell = UITextField()
        let alert = UIAlertController(title: "Add New Private ", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if textCell.text! != "" {
                
                let PrivateCategory = SecretCategory(context: self.context)
                PrivateCategory.nameOfSecrit = textCell.text!
                self.DataFromCategorySecrit.append(PrivateCategory)
                self.save()
                
                
            }
            
        }))
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Creat new Private"; textCell = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Edite data
    @objc  func editCategory(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            let touchpoint = gestureRecognizer.location(in: self.tableView)
            if let indexpath = tableView.indexPathForRow(at: touchpoint){
                var textcell = UITextField()
                let alert = UIAlertController(title: "Edit Private", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
                    
                    if textcell.text! != "" {
                        
                        self.DataFromCategorySecrit[indexpath.row].nameOfSecrit! = textcell.text!
                        self.save()
                    }
                    
                }))
                
                alert.addTextField { (alertTextField) in alertTextField.placeholder = self.DataFromCategorySecrit[indexpath.row].nameOfSecrit! ; textcell = alertTextField
                }
                
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func EditeItem(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func unlock(_ sender: UIBarButtonItem) {
        
         var textcell = UITextField()
        
        
        if sender.title == "Lock"
        {
            
             let alert = UIAlertController(title: "Edit password", message: "enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
                
                if textcell.text! != "" {
                    
                    self.DefaultUserPassword.set(textcell.text!, forKey: "password")
                }
              
                
            }))
            alert.addTextField { (alertTextField) in alertTextField.placeholder = "enter password" ; textcell = alertTextField
            }
             present(alert, animated: true, completion: nil)
            sender.title = " "
        }
        else{
            
            let alert = UIAlertController(title: "enter password", message: "enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
                if textcell.text! != "" {
                let password = self.DefaultUserPassword.string(forKey: "password")
                if password! == textcell.text! {
                    self.tableView.isHidden = false
                }
                }
                
                
            }))
            alert.addTextField { (alertTextField) in alertTextField.placeholder = "enter password" ; textcell = alertTextField
            }
            present(alert, animated: true, completion: nil)
            sender.title = ""
            
        }
        
        
    }
    
}
