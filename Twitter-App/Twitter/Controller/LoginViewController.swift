//
//  LoginCV.swift
//  Twitter
//
//  Created by Nikola Baci on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let tokenEndpoint = "https://api.twitter.com/oauth/request_token"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        TwitterAPICaller.client?.login(url: tokenEndpoint, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: { error in
            print(error)
        })
    }
}
