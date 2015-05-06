//
//  ViewController.swift
//  GithubUserSearch
//
//  Created by Kohei Arai on 5/5/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, GithubUserSearchAPIProtocol {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var position = 0
    var users = [User]()
    var api: GithubUserSearchAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = GithubUserSearchAPI(delegate: self)
        self.preButton.hidden = true
        self.nextButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        position = 0
        self.preButton.hidden = true
        self.nextButton.hidden = true
        
        api!.searchUsers(self.searchBox.text, page: 0)
    }
    
    func didRecieveUser(user: User) {
        users.append(user)
        showUser()
    }
    
    @IBAction func showPreUser(sender: AnyObject) {
        position--
        showUser()
    }
    
    @IBAction func showNextUser(sender: AnyObject) {
        position++
        showUser()
        if position == users.count - 2 {
            api!.searchUsers(self.searchBox.text, page: (position / 5) + 1)
         
        }
    }
    
    @IBAction func jumpToUserPage(sender: AnyObject) {
        println("jump to user page")
    }
    

    func showUser() {
        if users.count == 0 {
            self.preButton.hidden = true
            self.nextButton.hidden = true
        } else {
            self.preButton.hidden = false
            self.nextButton.hidden = false
        }
        
        if position == 0 {
            self.preButton.hidden = true
        } else if position == users.count - 1 {
            self.nextButton.hidden = true
        }
        
        self.userImage.image = users[position].userImage
        self.userName.text = users[position].userName
    }
}

