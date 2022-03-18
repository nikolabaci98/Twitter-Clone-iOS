//
//  LoginCV.swift
//  Twitter
//
//  Created by Nikola Baci on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: K.userDefaultForLogin) == true{
            performSegue(withIdentifier: K.loginToHomeSegue, sender: self)
        }
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        TwitterAPICaller.client?.login(url: K.userLoginTokenEndpoint, success: {
            UserDefaults.standard.set(true, forKey: K.userDefaultForLogin)
            self.performSegue(withIdentifier: K.loginToHomeSegue, sender: self)
        }, failure: { error in
            print(error)
        })
    }
    
}
