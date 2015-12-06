//
//  ActivityViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITextFieldDelegate {
    
    var activity: Activity?
    let dataManager = DataManager()

    @IBOutlet weak var saveActivity: UIBarButtonItem!
    
    @IBOutlet weak var activityName: UITextField!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityName.delegate = self
        checkValidActivityName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        //saveActivity.enabled = false
    }
    
    func checkValidActivityName() {
        // Disable the Save button if the text field is empty.
        let text = activityName.text ?? ""
        //saveActivity.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidActivityName()
        navigationItem.title = textField.text
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveActivity === sender {
            let name = activityName.text ?? ""
            activity = Activity(name: name)
        }
    }

}
