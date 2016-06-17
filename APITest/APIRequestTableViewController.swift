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
    var requestStore = RequestStore.shared()
    
    var urlAsString = ""
    var response = ""
    var request = ""
    var data = ""
    
    var httpMethods = ["GET", "POST", "PUT", "DELETE"]
    var selectedMethod = Method.GET
    
    // for building up request body name / value pairs
    var names = [String]()
    var values = [String]()
    var params = [String : String]()
    
    // for building up request header
    var headerFields = [String]()
    var headerValues = [String]()
    var headerDict = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func getHtttpMethodAsString() -> String
    {
        if selectedMethod == Method.GET { return "GET" }
        if selectedMethod == Method.POST { return "POST" }
        if selectedMethod == Method.PUT { return "PUT" }
        if selectedMethod == Method.DELETE { return "DELETE" }
        
        return "GET"
    }
    
    
    @IBAction func savePressed(sender: UIBarButtonItem)
    {
        let theRequest = HttpRequest()
        
        if let url = (tableView.viewWithTag(100) as! UITextField).text
        {
            theRequest.urlAsString = url
        }
        else { theRequest.urlAsString = "" }
        
        theRequest.httpMethod = getHtttpMethodAsString()
        
        for (index, name) in names.enumerate()
        {
            theRequest.requestBody[name] = values[index]
        }
        
        for (index, name) in headerFields.enumerate()
        {
            theRequest.requestHeader[name] = headerValues[index]
        }
        
        requestStore.createRequest(theRequest)
        requestStore.save()
    }
    
    
    @IBAction func addHeaderPressed(sender: UIBarButtonItem)
    {
        
        let alertVC = UIAlertController(title: "Request Header", message: "Add Field", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertVC.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Field"
        }
        
        alertVC.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Value"
        }
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in self.addHeaderField(alertVC) })
        alertVC.addAction(action)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      
        alertVC.addAction(cancel)
        
        presentViewController(alertVC, animated: true, completion: nil)

    }
    
    
    func addHeaderField(alertController :UIAlertController)
    {
        if let field = alertController.textFields![0].text
        {
            headerFields.append(field)
        }
        if let value = alertController.textFields![1].text
        {
            headerValues.append(value)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem)
    {
       
        
        let alertVC = UIAlertController(title: "Request Body", message: "Add Parameter", preferredStyle: UIAlertControllerStyle.Alert)
      
        alertVC.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Name"
        }
        
        alertVC.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Value"
        }
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in self.addParameter(alertVC) })
        alertVC.addAction(action)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertVC.addAction(cancel)
        
        presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    
    func addParameter(alertController :UIAlertController)
    {
        if let name = alertController.textFields![0].text
        {
            names.append(name)
        }
        if let value = alertController.textFields![1].text
        {
            values.append(value)
        }
        
        tableView.reloadData()
    }
    
    
    
    @IBAction func submitPressed(sender: UIButton) {
        
        urlAsString = (tableView.viewWithTag(100) as! UITextField).text!
        
        for (index, name) in names.enumerate()
        {
            params[name] = values[index]
        }
        
        for (index, name) in headerFields.enumerate()
        {
            headerDict[name] = headerValues[index]
        }
        
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
        
        Alamofire.request(selectedMethod, urlAsString, parameters: params, encoding: ParameterEncoding.JSON, headers: headerDict).responseJSON(options: NSJSONReadingOptions.MutableContainers)
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
        if segue.identifier == "responseSegue"
        {
            let nextVC = segue.destinationViewController as! ResultsTableViewController
        
            nextVC.request = request
            nextVC.response = response
            nextVC.data = data
        }
        
        // else browse saved request
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        
        if section == 2
        {
            return headerFields.count
        }
        if section == 3
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
            return 110
        }
        
        if indexPath.section == 3
        {
            return 110
        }
        
        return 80
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section
        {
        case 0:
            return "URL"
        case 1:
            return "HTTP Method"
        case 2:
            return "Request Headers"
        case 3:
            return "Request Body"
        default:
            return ""
        }
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
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderTableViewCell
            
            cell.field.text = headerFields[indexPath.row]
            cell.value.text = headerValues[indexPath.row]
            
            return cell
        }
        
        if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath) as! ParameterTableViewCell
            
            cell.name.text = names[indexPath.row]
            cell.value.text = values[indexPath.row]
            
            return cell
        }
        
        if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("SubmitCell", forIndexPath: indexPath)
            
            return cell
        }

        // Configure the cell...

        return tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath)
        
        
    }



    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Allow delete on request header and request body params
        if indexPath.section != 3 && indexPath.section != 2 { return false }
        
        return true
    }
  
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if indexPath.section == 2
            {
                headerFields.removeAtIndex(indexPath.row)
                headerValues.removeAtIndex(indexPath.row)
            }
            if indexPath.section == 3
            {
                names.removeAtIndex(indexPath.row)
                values.removeAtIndex(indexPath.row)
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

 

}
