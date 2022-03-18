//
//  Constants.swift
//  Twitter
//
//  Created by Nikola Baci on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation
import CoreGraphics

struct K {
    //API Endpoints
    static let twitterEndpoint = "https://api.twitter.com"
    static let consumerKey = "5lUJuO5AUpPUCez4ewYDFrtgh"
    static let consumerSecret = "s5ynGqXzstUZwFPxVyMDkYh197qvHOcVM3kwv1o2TKhS1avCdS"
    
    static let userLoginTokenEndpoint = "https://api.twitter.com/oauth/request_token"
    static let homeTimelineEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    
    static let postTweetEndpoint = "https://api.twitter.com/1.1/statuses/update.json"
    static let favoriteTweetEndpoint = "https://api.twitter.com/1.1/favorites/create.json"
    static let unfavoriteTweetEndpoint = "https://api.twitter.com/1.1/favorites/destroy.json"
    static let retweetEndpoint = "https://api.twitter.com/1.1/statuses/retweet/"
    static let unretweetEndpoint = "https://api.twitter.com/1.1/statuses/unretweet/"
    static let userProfileEndpoint = "https://api.twitter.com/1.1/account/verify_credentials.json"
    
    //Segue Identifiers
    static let loginToHomeSegue = "LoginToHome"
    static let homeToComposeTweetSegue = "HomeToTweet"
    static let homeToUserProfileSegue = "HomeToProfile"
    
    
    //User Defaults
    static let userDefaultForLogin = "userLoggedIn"
    
    //General Constants
    static let estimatedRowHightTableView: CGFloat = 150
    static let numberOfSectionsTableView = 1
    static let initialNumberOfTweets = 6
    static let stackPositionWithMediaView = 2
}
