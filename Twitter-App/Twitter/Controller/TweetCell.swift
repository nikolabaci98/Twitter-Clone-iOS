//
//  TweetCell.swift
//  Twitter
//
//  Created by Nikola Baci on 3/7/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var twitterProfileImageView: UIImageView!
    @IBOutlet weak var twitterUsernameLabel: UILabel!
    @IBOutlet weak var twitterContentLabel: UILabel!
    
    func configure(tweet: NSDictionary) {
        let user = tweet["user"] as! NSDictionary
        twitterUsernameLabel.text = user["name"] as? String
        twitterContentLabel.text = tweet["text"] as? String
        twitterProfileImageView.af_setImage(withURL: URL(string: user["profile_image_url_https"] as! String)!)
        twitterProfileImageView.layer.cornerRadius = 24
    }
}
