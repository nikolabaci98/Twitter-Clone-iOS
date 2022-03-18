//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Nikola Baci on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableViewController: UITableViewController {

    
    @IBOutlet var tweetTableView: UITableView!
    let homeScreen = HomeScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = homeScreen.getUIRefreshController()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = K.estimatedRowHightTableView
        homeScreen.setTableViewDelegate(table: tweetTableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeScreen.initHomeScreenTweets()
    }
    
    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        homeScreen.logoutUser()
        dismiss(animated: true)
    }
    
    @IBAction func tweet(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.homeToComposeTweetSegue, sender: self)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.homeToUserProfileSegue, sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return K.numberOfSectionsTableView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreen.getTweetArrayCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if indexPath.row >= homeScreen.getTweetArrayCount() {
            return cell
        }
        cell.configure(tweet: homeScreen.getTweetAtIndex(indexPath.row), parent: self, indexRow: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == homeScreen.getTweetArrayCount() {
            homeScreen.loadMoreTweets()
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
