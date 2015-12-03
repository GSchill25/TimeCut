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

    @IBOutlet weak var activity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startPressed(sender: AnyObject) {
        print("Started Timer")
    }
    
    @IBAction func endPressed(sender: AnyObject) {
        let entityDescription = NSEntityDescription.entityForName("Timings", inManagedObjectContext: managedObjectContext)
        
        let timing = Timings(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        timing.activity = activity.text
        
        do {
            try managedObjectContext.save()
            print("saved")
        } catch {
            print("Error saving")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

