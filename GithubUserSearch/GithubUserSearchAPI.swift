//
//  GithubUserSearchAPI.swift
//  GithubUserSearch
//
//  Created by Kohei Arai on 5/5/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import Foundation

protocol GithubUserSearchAPIProtocol {
    func didRecieveAPIResults(results: NSArray)
}

class GithubUserSearchAPI {
    
    let delegate:GithubUserSearchAPIProtocol
    init(delegate: GithubUserSearchAPIProtocol) {
        self.delegate = delegate
    }
    
    func searchUsers(q: String, page: Int) {
        let qString = q.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        if let escapedQString = qString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "https://api.github.com/search/users?q=\(escapedQString)&per_page=\(page)"
            
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(
                url!,
                completionHandler: {
                    (data, response, error) -> Void in
                    if error != nil {
                        println(error.localizedDescription)
                    }
                    var err: NSError?
                    if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                        if err != nil {
                            println("JSON error: \(err!.localizedDescription)")
                        }
                        if let results: NSArray = jsonResult["results"] as? NSArray {
                            self.delegate.didRecieveAPIResults(results)
                        }
                    }
                }
            )
            task.resume()
        }
    }
}