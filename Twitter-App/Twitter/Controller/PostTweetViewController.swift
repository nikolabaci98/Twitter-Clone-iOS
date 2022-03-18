//
//  PostTweetViewController.swift
//  Twitter
//
//  Created by Nikola Baci on 3/13/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextLabel: UITextView!
    @IBOutlet weak var userProfileImage: UIImageView!
    let userProfileURL: String? = nil
    let placeholder = "What's happening?"
    let numberOfCharactersAllowed = 280
    var numberOfCharactersRemaining = 280
    @IBOutlet weak var numberOfCharactersLabel: UILabel!
    var isEmptyTextView = true
    var userProfile: NSDictionary? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextLabel.becomeFirstResponder()
        tweetTextViewSetup()
        tweetTextLabel.delegate = self
        TwitterAPICaller.client?.getUserProfile(success: { data in
            self.userProfile = data
            self.userProfileSetup()
        }, failure: { error in
            print(error)
        })
    }
    
    func userProfileSetup(){
        let profileURL = URL(string: userProfile?["profile_image_url"] as! String)
        userProfileImage.layer.cornerRadius = 24
        userProfileImage.af_setImage(withURL: profileURL!)
    }
    
    func tweetTextViewSetup() {
        isEmptyTextView = true
        tweetTextLabel.text = placeholder
        tweetTextLabel.textColor = .lightGray
        numberOfCharactersLabel.text = "\(numberOfCharactersAllowed)"
        numberOfCharactersRemaining = numberOfCharactersAllowed
        goToInitialPosition()
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if isEmptyTextView {
            isEmptyTextView = false
            tweetTextLabel.text = "\(tweetTextLabel.text.prefix(1))"
            tweetTextLabel.textColor = UIColor.init(named: "TextViewColor")
        
        }
        numberOfCharactersRemaining = numberOfCharactersAllowed - textView.text.count
        numberOfCharactersLabel.text = "\(numberOfCharactersRemaining)"
        if !isEmptyTextView && numberOfCharactersRemaining == 280 {
            tweetTextViewSetup()
        }
        if(numberOfCharactersRemaining < 0){
            numberOfCharactersLabel.textColor = .systemPink
        }
    }
    
    @IBAction func trashTweet(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if isEmptyTextView {
            goToInitialPosition()
        }
    }
    
    func goToInitialPosition() {
        let initPosition = tweetTextLabel.beginningOfDocument
        tweetTextLabel.selectedTextRange = tweetTextLabel.textRange(from: initPosition, to: initPosition)
    }
    
    @IBAction func postTweet(_ sender: UIBarButtonItem) {
        if !tweetTextLabel.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextLabel.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { error in
                print("Cound not post tweet. \(error)")
            })
        } else {
            print("Tweet is empty!")
        }
        
    }
}
