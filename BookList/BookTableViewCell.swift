//
//  BookTableViewCell.swift
//  BookList
//
//  Created by naoki morikubo on 2018/05/05.
//  Copyright © 2018年 naoki morikubo. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var wishLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!

  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .medium
    return dateFormatter
  }()

  override func awakeFromNib() {
        super.awakeFromNib()
    }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }

  func configureWithBook(book: Book) {
    titleLabel.text = book.title
    authorLabel.text = book.author
    wishLabel.isHidden = !(book.wish)
    dateLabel.text = dateFormatter.string(from: book.registeredDate! as Date)
  }

}
