//
//  Book+CoreDataProperties.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/05.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var registeredDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var url: NSObject?
    @NSManaged public var wish: Bool
    @NSManaged public var photo: Photo?
    @NSManaged public var shelf: Shelf?

}
