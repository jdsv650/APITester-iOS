//
//  APIRequestTableViewController.swift
//  APITest
//
//  Created by James on 6/12/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit
import Alamofire

class APIRequestTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var urlAsString = ""
    var response = ""
    var request = ""
    var data = ""
    
    var httpMethods = ["GET", "POST", "PUT", "DELETE"]
    var selectedMethod = Method.GET
    
    var names = [String]()
    var values = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    @IBAction func addPressed(sender: UIBarButtonItem)
    {
        names.append("")
        values.append("")
        tableView.reloadData()
        
    }
    
    
    @IBAction func submitPressed(sender: UIButton) {
        
        urlAsString = (tableView.viewWithTag(100) as! UITextField).text!
        makeCall()
    }
    
    
    // MARK: Picker source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return httpMethods.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return httpMethods[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedText = httpMethods[row]
        
        switch selectedText {
        case "GET":
            selectedMethod = Method.GET
        case "POST":
            selectedMethod = Method.POST
        case "PUT":
            selectedMethod = Method.PUT
        case "DELETE":
            selectedMethod = Method.DELETE
        default:
            selectedMethod = Method.GET
        }
    }

    
    
    func makeCall()
    {
        
        
        Alamofire.request(selectedMethod, urlAsString, parameters: nil, encoding: ParameterEncoding.JSON, headers: nil).responseJSON(options: NSJSONReadingOptions.MutableContainers)
        { (Response) in
            
            print(Response.request)
            print("")
            print(Response.response)
            print("")
            print(Response.result)
            
            
            if let req = Response.request
            {
                self.request = "\(req)"
            }
            
            if let resp = Response.response
            {
                self.response = "\(resp)"
            }
            
            
            // var resultAsJSON: NSDictionary
            
            switch Response.result
            {
            case .Success(let theData):
                // resultAsJSON = theData as! NSDictionary
                self.data = "\(theData)"
                print("response = \(self.data)")
                
                self.performSegueWithIdentifier("responseSegue", sender: self)
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                
                return
            }
            
            if Response.response?.statusCode == 200 || Response.response?.statusCode == 204
            {
                
                
            }
            
        }
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! ResultsTableViewController
        
        nextVC.request = request
        nextVC.response = response
        nextVC.data = data
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if section == 2
        {
            return names.count
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 60
        }
        
        if indexPath.section == 1
        {
            return 80
        }
        
        if indexPath.section == 2
        {
            return 100
        }
        
        return 80
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            return tableView.dequeueReusableCellWithIdentifier("URLCell", forIndexPath: indexPath)
        }
        
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("MethodCell", forIndexPath: indexPath)
            
          return cell
        }
        
        if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = names[indexPath.row]
            
            return cell
        }
        
        if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("SubmitCell", forIndexPath: indexPath)
            
            return cell
        }

        // Configure the cell...

        return tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath)
        
        
    }



    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        if indexPath.section != 2 { return false }
        
        return true
    }
  
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            names.removeAtIndex(indexPath.row)
            values.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

 

}
