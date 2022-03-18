//
//  HomeScreen.swift
//  Twitter
//
//  Created by Nikola Baci on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeScreen {
    
    private var tweetArray: [NSDictionary]
    private var numberOfTweets: Int
    private let myRefreshControl: UIRefreshControl
    var delegate: UITableView?
    
    init() {
        tweetArray = [NSDictionary]()
        numberOfTweets = K.initialNumberOfTweets
        myRefreshControl = UIRefreshControl()
        myRefreshControl.addTarget(self, action: #selector(pullRefreshTweets), for: .valueChanged)
    }
    
    @objc func pullRefreshTweets(){
        initHomeScreenTweets()
        self.myRefreshControl.endRefreshing()
    }
    
    func stopRefreshing() {
        myRefreshControl.endRefreshing()
    }
    
    func initHomeScreenTweets() {
        clearTweetArray()
        resetNumberOfTweets()
        requestTweets()
    }
    
    func loadMoreTweets() {
        clearTweetArray()
        addToNumberOfTweets(K.initialNumberOfTweets) //!
        requestTweets()
    }
    
    func requestTweets(){
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: K.homeTimelineEndpoint, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.delegate?.reloadData()
        }, failure: { error in
            print("could not load tweets \(error)")
        })
    }
    
    func logoutUser() {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: K.userDefaultForLogin)
    }
    
    
    //Getters & Setters
    func setTableViewDelegate(table: UITableView) {
        delegate = table
    }
    
    func getTweetArray() ->[NSDictionary] {
        return tweetArray
    }
    
    func getTweetAtIndex(_ index: Int) -> NSDictionary {
        return tweetArray[index]
    }
    
    func updateTweetAtIndex(_ index: Int, with tweet: NSDictionary) {
        tweetArray[index] = tweet
    }
    
    func appendTweet(tweet: NSDictionary) {
        tweetArray.append(tweet)
    }
    
    func clearTweetArray() {
        tweetArray.removeAll()
    }
    
    func getTweetArrayCount() -> Int {
        return tweetArray.count
    }
    
    func getNumberOfTweets() -> Int {
        return numberOfTweets
    }
    
    func addToNumberOfTweets(_ num: Int) {
        numberOfTweets += num
    }
    
    func resetNumberOfTweets() {
        numberOfTweets = K.initialNumberOfTweets
    }
    
    func getUIRefreshController() -> UIRefreshControl {
        return myRefreshControl
    }
}
