//
//  ParameterTableViewCell.swift
//  APITest
//
//  Created by James on 6/12/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class ParameterTableViewCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
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
