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
        if let savedActivities = loadActivities() {
            activities += savedActivities
        }
        if activities.isEmpty{
            loadSampleActivities()
        }
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
        
        // Fetches the appropriate activity for the data source layout.
        let activity = activities[indexPath.row]
        
        cell.nameLabel.text = activity.name
        
        return cell
    }
    
    func saveActivities() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(activities, toFile: Activity.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save activities...")
        }
    }
    
    func loadActivities() -> [Activity]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Activity.ArchiveURL.path!) as? [Activity]
    }
    
    @IBAction func unwindToActivityList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ActivityViewController, activity = sourceViewController.activity {
            let newIndexPath = NSIndexPath(forRow: activities.count, inSection: 0)
            activities.append(activity)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        saveActivities()
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTiming" {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ViewController
            
            // Get the cell that generated this segue.
            if let selectedActivityCell = sender as? ActivityTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedActivityCell)!
                let selectedActivity = activities[indexPath.row]
                targetController.activity = selectedActivity
            }
        }
        else if segue.identifier == "AddActivity" {
            print("Adding new activity.")
        }
    }

}
