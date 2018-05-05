//
//  CoreDataStack.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/04.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

  let context:NSManagedObjectContext

  let appDocumentDirURL: URL = {
    let fileManager = FileManager.default
    let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    return urls.last!
  }()

  init() {
    let bundle = Bundle.main
    guard let modelURL = bundle.url(forResource: "BookListModel", withExtension: "momd") else {
      fatalError()
    }

    // generate managed object model with modelURL
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError()
    }

    // generate coordinator with model object
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

    // generate context and asociate persistent store coordinator
    context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = coordinator
  }

  // add configure of persistent store
  func addPersistentStoreWithCompletionHandler(completionHandler: (() -> Void)?) {
    let backgroundQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)

    backgroundQueue.async {
      let dirURL = self.appDocumentDirURL
      let storeURL = dirURL.appendingPathComponent("BookList.sqlite")

      do {
        let coordinator = self.context.persistentStoreCoordinator!
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        completionHandler?()

      } catch let error as NSError {
        fatalError("error : \(error)")
      }
    }
  }

  // save changes of context to persistent store
  func saveContext() throws {
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        print("error : \(error)")
        throw error
      }
    }
  }

}
