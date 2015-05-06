//
//  ViewController.swift
//  GithubUserSearch
//
//  Created by Kohei Arai on 5/5/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var searchBox: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(self.searchBox.text)
        self.view.endEditing(true)
    }
    
    @IBAction func showPreUser(sender: AnyObject) {
        println("show previous user")
    }
    
    @IBAction func showNextUser(sender: AnyObject) {
        println("show next user")
    }
    
    @IBAction func jumpToUserPage(sender: AnyObject) {
        println("jump to user page")
    }
    

}

