//
//  ViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let stopwatch = Stopwatch()
    
    var activity: Activity?

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
         NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let activitySelected = activity{
            activityName.text = activitySelected.name
        }
        readyButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startPressed(sender: AnyObject) {
        print("Started Timer")
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateElapsedTimeLabel:", userInfo: nil, repeats: true)
        stopwatch.start()
        readyButton.enabled = true
        startButton.enabled = false
    }
    
    @IBAction func endPressed(sender: AnyObject) {
        stopwatch.stop()
        let entityDescription = NSEntityDescription.entityForName("Timings", inManagedObjectContext: managedObjectContext)
        
        let timing = Timings(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        timing.date = todaysDate()
        timing.activity = activityName.text
        timing.endTime = timerLabel.text
        
        do {
          try managedObjectContext.save()
                print("saved")
        } catch {
            print("Error saving")
        }
    }
    
    func todaysDate() -> String {
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
    }
    
    func updateElapsedTimeLabel(timer: NSTimer) {
        if stopwatch.isRunning {
            timerLabel.text = stopwatch.elapsedTimeAsString
        } else {
            timer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

