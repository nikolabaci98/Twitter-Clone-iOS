//
//  TweetParser.swift
//  Twitter
//
//  Created by Nikola Baci on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation


class TweetBrain {
    
    var tweetParser: TweetParser?
    var tweetFavorited: Bool
    var tweetRetweeted: Bool
    
    init(tweet: NSDictionary) {
        tweetFavorited = false
        tweetRetweeted = false
        tweetParser = TweetParser(with: tweet)
    }
    
    
    func getUsername() -> String? {
        return tweetParser?.getUsername()
    }
    
    func getTweetText() -> String? {
        return tweetParser?.getTweetText()
    }
    
    func getUserProfileImageURL() -> String? {
        return tweetParser?.getUserProfileImageURL()
    }
    
    func getTweetMediaURL() -> String? {
        return tweetParser?.getTweetMediaURL()
    }
    
    func getTweetID() -> Int {
        return tweetParser?.getTweetID() ?? 0
    }
    
    func getRetweetCount() -> String {
        if let count = tweetParser?.getRetweetCount() {
            if count >= 1000 {
                return "\(count / 1000)k"
            } else {
                return "\(count)"
            }
        } else {
            return ""
        }
    }
    
    func getFavoriteCount() -> String {
        if let count = tweetParser?.getFavoriteCount() {
            if count >= 1000 {
                return "\(count / 1000)k"
            } else {
                return "\(count)"
            }
        } else {
            return ""
        }
    }
    
    func didUserRetweet() -> Bool {
        tweetRetweeted = tweetParser?.didUserRetweet() ?? false
        return tweetParser?.didUserRetweet() ?? false
    }
    
    func didUserFavorite() -> Bool {
        tweetFavorited = tweetParser?.didUserFavorite() ?? false
        return tweetParser?.didUserFavorite() ?? false
    }
    
    func getTweetFavorited() -> Bool {
        return Bool(tweetFavorited)
    }
    
    func getTweetRetweeted() -> Bool! {
        return tweetRetweeted
    }
    
    func changeFavoritedValue() {
        tweetFavorited = !tweetFavorited
    }
    
    func changeRetweetedValue() {
        tweetRetweeted = !tweetRetweeted
    }
}


