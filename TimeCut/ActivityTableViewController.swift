//
//  ActivityTableViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {
    // MARK: Properties
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    func getTimingsForActivity(activity: String) -> String{
        /*let fetchRequest = NSFetchRequest(entityName: "Timings")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.executeRequest(deleteRequest)
        } catch let error as NSError {
            print(error)
        }*/
        
        var timings = [Timings]()
        var count = 0.0 as Float
        var averageTime = 0.0 as Float
        let fetchRequest = NSFetchRequest(entityName: "Timings")
        do{
            timings = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Timings]
        } catch let error as NSError{
            print("Could not retrieve coreData timings \(error)")
        }
        for timing in timings{
            if timing.activity! as NSString == activity{
                count += 1.0
                let str = timing.endTime as NSString!
                let minutesStr = str.substringWithRange(NSRange(location: 0, length: 2))
                let secondsStr = str.substringWithRange(NSRange(location:3, length: 4))
                var seconds = (secondsStr as NSString).floatValue
                let minutes = (minutesStr as NSString).floatValue
                seconds += minutes * 60
                averageTime += seconds
            }
        }
        averageTime /= count
        return NSString(format: "%.2f", averageTime) as String
    }
    
    var activities = [Activity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedActivities = loadActivities() {
            activities += savedActivities
        }
        if activities.isEmpty{
            loadSampleActivities()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
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
        let avgTime = getTimingsForActivity(activity.name)
        cell.nameLabel.text = activity.name + " Average Time: " + (avgTime as String)
        
        return cell
    }
    
    func loadList(notification: NSNotification){
            //load data here
        print("Reloading data")
        self.tableView.reloadData()
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
