//
//  JournalTableViewController.swift
//  Forest Calculator
//
//  Created by iMac on 03.11.15.
//  Copyright © 2015 MilNik. All rights reserved.
//

import UIKit
import CoreData

class JournalTableViewController: UITableViewController {

    @IBOutlet var journalTableView: UITableView!
    
    // clear journal функция, удаляющая все записи из Core Data
    @IBAction func clearJournalTableView(sender: AnyObject) {
        
        if !ansversArray.isEmpty {
            
            let clearAlert = UIAlertController(title: "Внимание!", message: "Вы действительно хотите удалить все записи?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel , handler: nil)
            
            let okAction = UIAlertAction(title: "Удалить", style: UIAlertActionStyle.Default) {
                Void in
                self.clearAllData()
                ansversArray.removeAll()
                self.journalTableView.reloadData()
                //self.outputText()
            }
            
            clearAlert.addAction(cancelAction)
            clearAlert.addAction(okAction)
            
            self.presentViewController(clearAlert, animated: true, completion: nil)
        }
    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //journalTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ansversArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let sum = ansversArray[indexPath.row]
        cell.textLabel!.text = sum.valueForKey("sum") as? String
        return cell
    }
    

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    */
    
    // MARK: - Core Data methods
    
    func clearAllData() {
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Resault")

        let result = try? context.executeFetchRequest(request) as! [NSManagedObject]
        if(result!.count>0)
        {
            for res in result! {
                context.deleteObject(res as NSManagedObject)
            }
            try? context.save()
        }

    }
    

}
