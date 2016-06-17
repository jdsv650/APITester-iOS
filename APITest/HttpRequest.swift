//
//  httpRequest.swift
//  APITest
//
//  Created by James on 6/16/16.
//  Copyright © 2016 James. All rights reserved.
//

import Foundation

public class HttpRequest: NSObject, NSCoding
{
    
    var urlAsString = ""
    var httpMethod = ""
    var requestBody = [String : String]()
    var requestHeader = [String : String]()

    
    override init()
    {
        super.init()
    }
    
    public func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(urlAsString, forKey: "urlAsString")
        aCoder.encodeObject(httpMethod, forKey: "httpMethod")
        aCoder.encodeObject(requestHeader, forKey: "requestHeader")
        aCoder.encodeObject(requestBody, forKey: "requestBody")
    }
    
    public required init?(coder aDecoder: NSCoder) // NS_DESIGNATED_INITIALIZER
    {
        urlAsString = aDecoder.decodeObjectForKey("urlAsString") as! String
        httpMethod = aDecoder.decodeObjectForKey("httpMethod") as! String
        requestHeader = aDecoder.decodeObjectForKey("requestHeader") as! [String : String]
        requestBody = aDecoder.decodeObjectForKey("requestBody") as! [String : String]
    }
    
    
}
