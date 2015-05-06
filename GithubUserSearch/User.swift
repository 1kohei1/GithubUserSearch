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
    
}