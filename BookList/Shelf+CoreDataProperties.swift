//
//  Shelf+CoreDataProperties.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/05.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//
//

import Foundation
import CoreData


extension Shelf {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shelf> {
        return NSFetchRequest<Shelf>(entityName: "Shelf")
    }

    @NSManaged public var name: String?
    @NSManaged public var displayOrder: Int16
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension Shelf {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}
