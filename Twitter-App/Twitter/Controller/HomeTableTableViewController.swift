//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Nikola Baci on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int = 0
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    @objc func loadTweets(){
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 5
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { error in
            print("could not load tweets")
            print(error)
        })
    }
        
    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        dismiss(animated: true)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.configure(tweet: tweetArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadTweets()
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweetArray[indexPath.row]
        let stringURL = "https://twitter.com/TwitterDev/status/\(tweet["id"])"
        
        let url = URL(string: stringURL)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                return
        }
            if data != nil {
                let str = String(decoding: data!, as: UTF8.self)
            }
        }
        task.resume()
    }

}
