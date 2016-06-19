//
//  BookmarkedRequestsTableViewController.swift
//  APITest
//
//  Created by James on 6/16/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

// To notify delegate of selected request
protocol BookmarkedRequestsDelegate :class
{
    func didSelectRequest(controller: BookmarkedRequestsTableViewController, httpRequest: HttpRequest)
}



class BookmarkedRequestsTableViewController: UITableViewController {

    // declare the delegate
    weak var delegate: BookmarkedRequestsDelegate? = nil
    
    var requestStore = RequestStore.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestStore.count()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkedRequestCell", forIndexPath: indexPath) as! BookmarkTableViewCell

        // Configure the cell...

        if let theRequest = requestStore.getRequest(indexPath.row)
        {
            cell.urlLabel.text = theRequest.urlAsString
            cell.methodlabel.text = theRequest.httpMethod
            
            var requestAsString = ""
            
            for (field, value) in theRequest.requestHeader
            {
                requestAsString += field
                requestAsString += " \(value)"
            }
            cell.headerslabel.text = requestAsString
            
            requestAsString = ""
            for (name, value) in theRequest.requestBody
            {
                requestAsString += name
                requestAsString += " \(value), "
            }
            
            cell.bodylabel.text = requestAsString

        }
        
       // cell.textLabel?.text = .urlAsString

        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // call the delegate
        if let theRequest = requestStore.getRequest(indexPath.row)
        {
            delegate?.didSelectRequest(self, httpRequest: theRequest)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            requestStore.delete(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
