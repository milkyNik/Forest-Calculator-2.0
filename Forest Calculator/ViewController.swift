//
//  ViewController.swift
//  Forest Calculator
//
//  Created by iMac on 03.11.15.
//  Copyright © 2015 MilNik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBAction func addValueInModel(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction) -> Void in
                
                let textField = alert.textFields![0]
                self.saveSum(textField.text!)
                
                
                
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Core Data
    
    func saveSum(_sum: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Resault",
            inManagedObjectContext:
            managedContext)
        
        let sum = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
      
        sum.setValue(_sum, forKey: "sum")
        
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
        }  
        
        ansversArray.append(sum)
        
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Resault")
        
        var error: NSError?
        
        let fetchedResults = try?
            managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        
        if let results = fetchedResults {
            ansversArray = results!
        } else {
            print("Could not fetch \(error), \(error!.userInfo)")
        }
    }

}

