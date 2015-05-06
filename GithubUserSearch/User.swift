//
//  User.swift
//  GithubUserSearch
//
//  Created by Kohei Arai on 5/5/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import Foundation
import UIKit

class User {
    let userName: String
    let userProfileURL: String
    let userImage: UIImage
    
    init (userName: String, userProfileURL: String, userImage: UIImage) {
        self.userName = userName
        self.userProfileURL = userProfileURL
        self.userImage = userImage
    }
    
    static func usersWithJson(results: NSArray) -> [User] {
        var users = [User]()
        
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
                        if error != nil {
                            var userImage = UIImage(data: data)
                            var user = User(userName: userName, userProfileURL: userProfileURL, userImage: userImage!)
                            users.append(user)
                        }
                })
            }
        }
        return users
    }
}