//
//  TimeGraphViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/10/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit
import CoreData

class TimeGraphViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let localfilePath = NSBundle.mainBundle().URLForResource("graph", withExtension: "html")
        let myRequest = NSURLRequest(URL: localfilePath!)
        let dataStr = getDataString()
        print(dataStr)
        webView.stringByEvaluatingJavaScriptFromString(dataStr)
        webView.loadRequest(myRequest)
    }
    
    func getDataString() -> String {
        let activities = NSKeyedUnarchiver.unarchiveObjectWithFile(Activity.ArchiveURL.path!) as? [Activity]
        var dataStr = "var data = ["
        var activityArray = Dictionary<String, Float>()
        if let unwrapActivities = activities{
            for activity in unwrapActivities{
                activityArray[activity.name] = getTimingsForActivity(activity.name)
            }
        }
        for (act, avgTime) in activityArray{
            var color = getRandomColor()
            let highlight = color + ",0.5)"
            color += ",0.9)"
            dataStr += "{ value: \(avgTime), label: '\(act)', color: '\(color)', highlight: '\(highlight)'},"
        }
        dataStr.removeAtIndex(dataStr.endIndex.predecessor())
        dataStr += "]"
        return dataStr
    }
    
    func getRandomColor() -> String{
        let randomRed = arc4random_uniform(255)
        let randomGreen = arc4random_uniform(255)
        let randomBlue = arc4random_uniform(255)
        let color = "rgba(\(randomRed),\(randomGreen),\(randomBlue)"
        return color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTimingsForActivity(activity: String) -> Float{
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
        if count > 0{
            averageTime /= count
        }
        else{
            return 1.0
        }
        return averageTime
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
