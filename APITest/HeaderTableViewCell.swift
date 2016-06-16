//
//  HeaderTableViewCell.swift
//  APITest
//
//  Created by James on 6/15/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
