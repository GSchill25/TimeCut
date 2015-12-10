//
//  WelcomeViewController.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/10/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let localfilePath = NSBundle.mainBundle().URLForResource("welcome", withExtension: "html")
        let myRequest = NSURLRequest(URL: localfilePath!)
        welcomeWebView.loadRequest(myRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
