//
//  ViewController.swift
//  FacebookLoginPostPhoto
//
//  Created by Emiko Clark on 6/4/16.
//  Copyright © 2016 Emiko Clark. All rights reserved.
//

import UIKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    let loginButton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email","public_profile"]
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginButton)
        loginButton.center = self.view.center
        loginButton.delegate = self
    
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            print(token)
        }
    }

    func fetchProfile() {
        print("fetch profile")
        let parameters  = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error ) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
            
            print(result)
            if let picture = result["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                print(url)
            }
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Completed Login")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

