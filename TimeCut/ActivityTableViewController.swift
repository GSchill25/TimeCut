//
//  ActivityTableViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController {
    // MARK: Properties
    
    var activities = [Activity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleActivities()
    }
    
    func loadSampleActivities() {
        let act1 = Activity(name: "Class")
        let act2 = Activity(name: "Work")
        let act3 = Activity(name: "Practice")
        
        activities += [act1, act2, act3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ActivityTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ActivityTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let activity = activities[indexPath.row]
        
        cell.nameLabel.text = activity.name
        
        return cell
    }
    
    @IBAction func unwindToActivityList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ActivityViewController, activity = sourceViewController.activity {
            let newIndexPath = NSIndexPath(forRow: activities.count, inSection: 0)
            activities.append(activity)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}