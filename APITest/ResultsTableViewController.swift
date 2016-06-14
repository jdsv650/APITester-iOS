//
//  ResultsTableViewController.swift
//  APITest
//
//  Created by James on 6/12/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var dataTextView: UITextView!
    
    var request = ""
    var response = ""
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTextView.text = request
        responseTextView.text = response
        dataTextView.text = data
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    
    
    

 
    

}
