//
//  Photo+CoreDataProperties.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/05.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var book: Book?

}
