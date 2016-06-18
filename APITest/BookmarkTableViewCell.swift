//
//  BookmarkTableViewCell.swift
//  APITest
//
//  Created by James on 6/18/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var bodylabel: UILabel!
    @IBOutlet weak var headerslabel: UILabel!
    @IBOutlet weak var methodlabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
