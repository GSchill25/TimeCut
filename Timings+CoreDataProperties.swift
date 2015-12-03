//
//  Timings+CoreDataProperties.swift
//  TimeCut
//
//  Created by Graham Schilling on 12/3/15.
//  Copyright © 2015 Graham Schilling. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Timings {

    @NSManaged var startTime: String?
    @NSManaged var endTime: String?
    @NSManaged var activity: String?
    @NSManaged var date: NSDate?

}
