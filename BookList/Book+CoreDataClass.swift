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
  public override func awakeFromInsert() {
    super.awakeFromInsert()

    setPrimitiveValue(Date(), forKey: "registeredDate")
  }

}
