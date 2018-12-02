//
//  InfoPrivateViewController.swift
//  TooTask
//
//  Created by mohamed hashem on 11/22/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import CoreData

class InfoPrivateViewController: UIViewController {

    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var deleteDate: UILabel!
    @IBOutlet weak var dataInfoo: UITextView!
    @IBOutlet weak var dataDeleted: UITextView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var info : [SecritInfo] = []
    
    var SelectedInfo : SecretCategory? {
        didSet{
            
           load()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if info.isEmpty{
            createDate.text! = "No Date"
            deleteDate.text! = "No Date"
            dataInfoo.text!  = "No Data"
            dataDeleted.text! = "No Data Deleted"
            
        }else{
        createDate.text! = info[0].dateInfo!.description
        deleteDate.text! = info[0].lastDateInfoModefied!.description
        dataInfoo.text! = info[0].dataInfo!
        dataDeleted.text! = info[0].deletedInfo!
        }
        
        createDate.isEnabled = false
        deleteDate.isEnabled = false
        dataInfoo.isEditable = false
        dataDeleted.isEditable = false
        
    }
    
    func load(with request: NSFetchRequest<SecritInfo> = SecritInfo.fetchRequest(), predicate: NSPredicate? = nil) {
       
         let categorypredicate =  NSPredicate(format: "parentSecrite.nameOfSecrit MATCHES %@", SelectedInfo!.nameOfSecrit!)
        
        if let additionalpredicat = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate , additionalpredicat])
        }else {
            request.predicate = categorypredicate
        }
        
        do{
            info =  try context.fetch(request)
         
        }catch{
            print("Error in fetch data \(error)")
        }
    }
    
    
    func saveItem() {
        
        do{
            try  context.save()
           
        }catch{
            print("Error saving context \(error)")
        }
      
    }

    @IBAction func addInfo(_ sender: UIBarButtonItem) {
        
        createDate.isEnabled = true
        deleteDate.isEnabled = true
        dataInfoo.isEditable = true
        dataDeleted.isEditable = true
        
       
    }
    
    @IBAction func SaveAdd(_ sender: UIBarButtonItem) {
        if info.isEmpty {
            let newItem = SecritInfo(context: self.context)
                    newItem.dataInfo = dataInfoo.text!
                    newItem.dateInfo = Date()
                    newItem.deletedInfo = ""
                    newItem.lastDateInfoModefied = Date()
                    newItem.parentSecrite = self.SelectedInfo
            self.saveItem()
        }else{

        
        info[0].dataInfo = dataInfoo.text!
        info[0].dateInfo  = Date()
        info[0].deletedInfo = ""
        info[0].lastDateInfoModefied = Date()
        
        
        self.saveItem()
        }
    }
    
    
    
}
