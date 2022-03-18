//
//  TweetParser.swift
//  Twitter
//
//  Created by Nikola Baci on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation

class TweetParser {
    
    var tweet: NSDictionary
    var user: NSDictionary?
    
    
    init(with tweet: NSDictionary){
        self.tweet = tweet
        getUserDict()
    }
    
    func getUserDict() {
        user = tweet["user"] as? NSDictionary
    }
    
    func getTweetText() -> String? {
        return tweet["text"] as? String
    }
    
    func getUsername() -> String? {
        return user?["name"] as? String
    }
    
    func getUserProfileImageURL() -> String? {
        return user?["profile_image_url_https"] as? String
    }
    
    func getTweetMediaURL() -> String? {
        let entities = tweet["entities"] as! NSDictionary
        let mediaTuple = entities["media"] as? NSArray
        let mediaURLs = mediaTuple?[0] as? NSDictionary
        return mediaURLs?["media_url_https"] as? String
    }
    
    func getRetweetCount() -> Int {
        return (tweet["retweet_count"] as? Int ?? 0)
    }
    
    func getFavoriteCount() -> Int {
        return (tweet["favorite_count"] as? Int ?? 0)
    }
    
    func didUserRetweet() -> Bool {
        return tweet["retweeted"] as! Bool
    }
    
    func didUserFavorite() -> Bool {
        return tweet["favorited"] as! Bool
    }
    
    func getTweetID() -> Int {
        return tweet["id"] as! Int
    }
}
