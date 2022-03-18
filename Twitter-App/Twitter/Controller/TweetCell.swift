//
//  TweetCell.swift
//  Twitter
//
//  Created by Nikola Baci on 3/7/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import WebKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var twitterProfileImageView: UIImageView!
    @IBOutlet weak var twitterUsernameLabel: UILabel!
    @IBOutlet weak var twitterContentLabel: UILabel!
    @IBOutlet weak var tweetMediaView: UIImageView!
    @IBOutlet weak var tweetContentStack: UIStackView!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    var tweetFavorited: Bool = false
    var tweet: NSDictionary? = nil
    var tweetRetweeted: Bool = false
    var delegate: HomeTableViewController? = nil
    var row: Int? = nil
    
    
    var tweetBrain: TweetBrain? = nil
    
    func configure(tweet: NSDictionary, parent: HomeTableViewController, indexRow: Int) {
        
        tweetBrain = TweetBrain(tweet: tweet)
        
        row = indexRow
        delegate = parent
        
        twitterUsernameLabel.text = tweetBrain?.getUsername() ?? ""
        twitterContentLabel.text = tweetBrain?.getTweetText() ?? ""
        twitterProfileImageView.layer.cornerRadius = 24
        if let url = URL(string: tweetBrain?.getUserProfileImageURL() ?? "") {
            twitterProfileImageView.af_setImage(withURL: url)
        }
        retweetButton.setTitle(tweetBrain?.getRetweetCount(), for: .normal)
        likeButton.setTitle(tweetBrain?.getFavoriteCount(), for: .normal)
        

        if let url = URL(string: tweetBrain?.getTweetMediaURL() ?? "") {
            tweetContentStack.arrangedSubviews[K.stackPositionWithMediaView].isHidden = false
            tweetMediaView.af_setImage(withURL: url, completion:  {
                response in
                // Check if the image isn't already cached
                if response.response != nil {
                    // Force the cell update
                    self.delegate?.tweetTableView.beginUpdates()
                    self.delegate?.tweetTableView.endUpdates()
                }
            })
        } else {
            tweetContentStack.arrangedSubviews[K.stackPositionWithMediaView].isHidden = true
        }
        
        
        if let retweeted = tweetBrain?.didUserRetweet() {
            if retweeted {
                setColoredLoop()
            } else {
                setGrayLoop()
            }
        }
        
        if let favorited = tweetBrain?.didUserFavorite() {
            if favorited {
                setColoredHeart()
            } else {
                setGrayHeart()
            }
        }
    }

    
    @IBAction func retweetClicked(_ sender: UIButton) {
        if let retweeted = tweetBrain?.getTweetRetweeted() {
            if !retweeted {
                TwitterAPICaller.client?.retweet(tweetId: (tweetBrain?.getTweetID())!, success: { [self] in
                    self.setColoredLoop()
                    self.updateTweet()
                    self.tweetBrain?.changeRetweetedValue()
                }, failure: { error in
                    print("Tweet cound not be retwitted \(error)")
                })
            } else {
                TwitterAPICaller.client?.unretweet(tweetId: (tweetBrain?.getTweetID())!, success: { [self] in
                    self.setGrayLoop()
                    self.updateTweet()
                    self.tweetBrain?.changeRetweetedValue()
                }, failure: { error in
                    print("Tweet cound not be unretwitted \(error)")
                })
            }
        }
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        if let favorited = tweetBrain?.getTweetFavorited() {
            print(favorited)
            if !favorited {
                TwitterAPICaller.client?.favoriteTweet(tweetId: (tweetBrain?.getTweetID())!, success: { [self] in
                    self.setColoredHeart()
                    self.updateTweet()
                    self.tweetBrain?.changeFavoritedValue()
                }, failure: { error in
                    print("Not able to favorite this tweet \(error)")
                })
            } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetId: (tweetBrain?.getTweetID())!, success: {
                    self.setGrayHeart()
                    self.updateTweet()
                    self.tweetBrain?.changeFavoritedValue()
                }, failure: { error in
                    print("Not able to unfavorite this tweet \(error)")
                })
            }
        }
    }
    
    func updateTweet() {
        let id = tweetBrain?.getTweetID()
        let url = "https://api.twitter.com/1.1/statuses/show.json?id=\(id!)"
        let parameters = ["id": id]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: parameters as [String : Any], success: { updatedTweet in
            if self.row! < (self.delegate?.homeScreen.getTweetArrayCount())! {
                self.delegate?.homeScreen.updateTweetAtIndex(self.row!, with: updatedTweet)
                self.delegate?.tableView.reloadData()
            }
            
        }, failure: { error in
            print(error)
        })
    }
    
    
    func setColoredHeart() {
        tweetFavorited = true
        likeButton.setTitleColor(UIColor(red: 0xFF/0xFF, green: 0x57/0xFF, blue: 0x57/0xFF, alpha: 1.0), for: .normal)
        likeButton.setImage(UIImage(named: "heart_colored"), for: .normal)
    }
    
    func setGrayHeart() {
        tweetFavorited = false
        likeButton.setTitleColor(UIColor(red: 0xA6/0xFF, green: 0xA6/0xFF, blue: 0xA6/0xFF, alpha: 1.0), for: .normal)
        likeButton.setImage(UIImage(named: "heart_gray"), for: .normal)
    }
    
    func setColoredLoop() {
        tweetRetweeted = true
        retweetButton.setTitleColor(UIColor(red: 0x2e/0xFF, green: 0x90/0xFF, blue: 0xeb/0xFF, alpha: 1.0), for: .normal)
        retweetButton.setImage(UIImage(named: "loop_colored"), for: .normal)
    }
    
    func setGrayLoop() {
        tweetRetweeted = false
        retweetButton.setTitleColor(UIColor(red: 0xA6/0xFF, green: 0xA6/0xFF, blue: 0xA6/0xFF, alpha: 1.0), for: .normal)
        retweetButton.setImage(UIImage(named: "loop_gray"), for: .normal)
    }
}
