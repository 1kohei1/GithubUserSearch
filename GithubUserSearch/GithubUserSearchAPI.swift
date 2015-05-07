//
//  GithubUserSearchAPI.swift
//  GithubUserSearch
//
//  Created by Kohei Arai on 5/5/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import Foundation
import UIKit

protocol GithubUserSearchAPIProtocol {
    func didRecieveUser(user: User)
}

class GithubUserSearchAPI {
    
    let delegate:GithubUserSearchAPIProtocol
    init(delegate: GithubUserSearchAPIProtocol) {
        self.delegate = delegate
    }
    //AFNetworking
    func searchUsers(q: String, page: Int) {
        let qString = q.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        if let escapedQString = qString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "https://api.github.com/search/users?q=\(escapedQString)&per_page=5&page=\(page)"
            
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
                        if let results: NSArray = jsonResult["items"] as? NSArray {
                            self.pullUsersOutOfJSON(results)
                        }
                    }
                }
            )
            task.resume()
        }
    }
    
    func pullUsersOutOfJSON (results: NSArray) {
        for user in results {
            if let  userName = user["login"] as? String,
                    userProfileURL = user["html_url"] as? String,
                    imageURLString = user["avatar_url"] as? String
            {
                // fetch userImage by AsynchronousRequest
                var imageURL = NSURL(string: imageURLString)!
                var request: NSURLRequest = NSURLRequest(URL: imageURL)
                var mainQueue = NSOperationQueue.mainQueue()
                
                NSURLConnection.sendAsynchronousRequest(
                    request,
                    queue: mainQueue,
                    completionHandler: {
                        (response, data, error) -> Void in
                        if error == nil {
                            var userImage = UIImage(data: data)
                            var user = User(userName: userName, userProfileURL: userProfileURL, userImage: userImage!)
                            self.delegate.didRecieveUser(user)
                        }
                    }
                )
            }
        }
    }
}