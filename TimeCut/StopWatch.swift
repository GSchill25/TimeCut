//
//  StopWatch.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//

import Foundation

class Stopwatch {
    
    private var startTime: NSDate?
    
    var isRunning: Bool {
        if let startTime = self.startTime {
            return true
        } else {
            return false
        }
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
    
    var elapsedTime: NSTimeInterval {
        if let startTime = self.startTime {
            return -1 * startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeAsString: String {
        if elapsedTime == 0 {
            return "00:00.0"
        } else {
            let diffMinutes = Int(elapsedTime / 60)
            let diffSeconds = Int(elapsedTime % 60)
            let diffTenthSeconds = Int((elapsedTime * 10) % 10)
            let diffString: String = String(format: "%02d:%02d.%01d", diffMinutes, diffSeconds, diffTenthSeconds)
            return diffString
        }
    }
    
}
