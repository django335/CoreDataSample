//
//  BookTableViewController.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/05.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//

import UIKit
import CoreData

class BookTableViewController: UITableViewController {

  let coreDataStack = CoreDataStack()
  var books = [Book]()

  lazy var fetchRequest: NSFetchRequest<Book> = {
    let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()

    let sortDescriptor = NSSortDescriptor(key: "registeredDate", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]

    return fetchRequest
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 56.0

    navigationItem.leftBarButtonItem = editButtonItem

    userInteractionEnabled(enabled: false)
    coreDataStack.addPersistentStoreWithCompletionHandler {
      DispatchQueue.main.async {
        self.userInteractionEnabled(enabled: true)
        self.fetchBooks()
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func addBook(_ sender: UIBarButtonItem) {
    let newBook = NSEntityDescription.insertNewObject(forEntityName: "Book", into: coreDataStack.context) as! Book

    newBook.title = "title"
    newBook.author = "author"

    try! coreDataStack.saveContext()

    books.insert(newBook, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
  
  @IBAction func segmentChanged(_ sender: UISegmentedControl) {
    let wish = sender.selectedSegmentIndex == 1
    if wish {
      let predicate = NSPredicate(format: "wish == true", argumentArray: nil)
      fetchRequest.predicate = predicate
    } else {
      fetchRequest.predicate = nil
    }
    fetchBooks()
  }

  private func userInteractionEnabled(enabled:Bool) {
    navigationItem.rightBarButtonItem?.isEnabled = enabled
    navigationItem.leftBarButtonItem?.isEnabled = enabled
    (navigationItem.titleView as! UISegmentedControl).isEnabled = enabled
  }

  private func fetchBooks() {
    do {
//      books = try coreDataStack.context.execute(fetchRequest)
      books = try coreDataStack.context.fetch(fetchRequest)
    } catch let error as NSError {
      fatalError("error : \(error)")
    }
    tableView.reloadData()
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return books.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
    let book = books[indexPath.row]
    cell.configureWithBook(book: book)
    return cell
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    navigationItem.rightBarButtonItem?.isEnabled = !editing
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let book = books[indexPath.row]
      coreDataStack.context.delete(book)
      try! coreDataStack.saveContext()

      books.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

}
