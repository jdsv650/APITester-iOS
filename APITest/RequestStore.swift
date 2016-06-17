//
//  RequestStore.swift
//  APITest
//
//  Created by James on 6/16/16.
//  Copyright © 2016 James. All rights reserved.
//

import Foundation

class RequestStore
{
    //Singleton
    private struct Static
    {
        static let instance : RequestStore = RequestStore()  //static one instance only
    }
    
    class func shared() -> RequestStore
    {
    return Static.instance   // return the shared instance
    }
    
    private init()
    {
        load()
    }
    
    // the Http Requests to keep track of
    private var allRequests : [HttpRequest]!
    
    // MARK: CRUD methods - Create, Read, Update, Delete
    
    func createRequest() -> HttpRequest {
        let theRequest = HttpRequest()
        allRequests.append(theRequest)
        return theRequest
    }
    
    func createRequest(theRequest: HttpRequest) {
        allRequests.append(theRequest)
    }
    
    func getRequest(index:Int) -> HttpRequest {
        return allRequests[index]
    }
    
    func count() -> Int {
        return allRequests.count
    }
    
    // no need to update, requests passed by reference
    
    func delete(index:Int) {
        allRequests.removeAtIndex(index)
    }
    
    
    
    private func archiveFilePath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("RequestStore.plist")
        
        return path
    }
    
    func save()
    {
        NSKeyedArchiver.archiveRootObject(allRequests, toFile: archiveFilePath())
    }
    
    func load()  // fetch requests or create a new array of requests -- called in init()
    {
        let filePath = archiveFilePath()
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(filePath) {
            allRequests = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! [HttpRequest]
        }
        else
        {
            allRequests = [HttpRequest]()
        }
        
        
    }


    
    
}
