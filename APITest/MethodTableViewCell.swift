//
//  MethodTableViewCell.swift
//  APITest
//
//  Created by James on 6/12/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class MethodTableViewCell: UITableViewCell {

    @IBOutlet weak var methodPicker: UIPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
