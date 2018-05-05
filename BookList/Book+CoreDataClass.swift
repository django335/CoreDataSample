//
//  Book+CoreDataClass.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/04.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {

  var recently:NSNumber? {
    let cal = NSCalendar.current
    let oneMonthAgo = cal.date(byAdding: .month, value: -1, to: Date())
    let date = primitiveValue(forKey: "registeredDate") as! Date
    if cal.compare(date, to: oneMonthAgo!, toGranularity: .day) == .orderedDescending {
      return true
    }
    return false
  }

  public override func awakeFromInsert() {
    super.awakeFromInsert()

    setPrimitiveValue(Date(), forKey: "registeredDate")
  }

}
