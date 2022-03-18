//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Nikola Baci on 3/15/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage
class ProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var joinedDateLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var tweetTableView: UITableView!
    
    var userProfile: NSDictionary? = nil
    var userTweets: [NSDictionary]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterAPICaller.client?.getUserProfile(success: { data in
            self.userProfile = data
            self.userProfileSetup()
            self.getTweets()
        }, failure: { error in
            print(error)
        })
        
    }
    
    func getTweets() {
        let userID = userProfile?["id_str"] as! String
        let userTweetsEndpoint = "https://api.twitter.com/2/users/\(userID)/tweets"
        TwitterAPICaller.client?.getDictionariesRequest(url: userTweetsEndpoint, parameters: [:], success: { (tweets: [NSDictionary]) in
            self.userTweets = tweets
        }, failure: { error in
            print(error)
        })
    }
    
    
    func userProfileSetup(){
        let bannerURL = URL(string: userProfile?["profile_banner_url"] as! String)
        bannerImageView.af_setImage(withURL: bannerURL!)
        let profileURL = URL(string: userProfile?["profile_image_url"] as! String)
        profileImageView.layer.cornerRadius = 37.5
        profileImageView.layer.borderWidth = 3
        if #available(iOS 13.0, *) {
            profileImageView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            
        }
        profileImageView.af_setImage(withURL: profileURL!)
        displayNameLabel.text = userProfile?["name"] as? String
        usernameLabel.text = "@\(userProfile?["screen_name"] as! String)"
        userStatusLabel.text = userProfile?["description"] as? String
        joinedDateLabel.text = "Joined on \(getDate())"
        followingLabel.text = "\(userProfile?["friends_count"] as! Int) Following"
        followersLabel.text = "\(userProfile?["followers_count"] as! Int) Followers"
        favoriteLabel.text = "\(userProfile?["favourites_count"] as! Int) Favorites"
        numberTweetsLabel.text = "\(userProfile?["statuses_count"] as! Int) Tweets"

        
    }
    
    func getDate() -> String {
        let date = userProfile?["created_at"] as! String
        let words = date.split(separator:  " ")
        return "\(words[1]) \(words[words.count - 1])"
        
    }
}
