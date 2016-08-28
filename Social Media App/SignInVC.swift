//
//  ViewController.swift
//  Social Media App
//
//  Created by Matthew Wells on 2016-08-26.
//  Copyright © 2016 Matthew Wells. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FIRAuth.auth()?.currentUser) != nil {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func facebookButtonTapped(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("MATT: Unable to authenticate with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("MATT: User cancelled Facebook authentication")
            } else {
                print("MATT: Successfully authenticated facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.FirebaseAuth(credential)
                
            }
            
        }
    }
    
    func FirebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("MATT: Unable to authenticate with Firebase - \(error)")
            } else {
                print("MATT: Successfully authenticated with Firebase")
                self.performSegue(withIdentifier: "goToFeed", sender: nil)
            }
        })
    }
    @IBAction func signInTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("MATT: Email User authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("MATT: unable to authenticate with Firebase using email \(error)")
                        } else {
                            print("MATT: Successfully authenticated with email")
                            self.performSegue(withIdentifier: "goToFeed", sender: nil)
                        }
                    })
                }
            })
        }
    }
}

