//
//  ViewController.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/24/23.
//

import UIKit
import SwiftUI
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var signInWithGoogleButtonOutlet: UIButton!
    @IBOutlet weak var signInWithAppleAccountButtonOutlet: UIButton!
    @IBOutlet weak var playWithOutSignIn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.bool(forKey: "isSignInCompleted") {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let userInteractionViewController = storyBoard.instantiateViewController(withIdentifier: "UserInteractionViewController") as! UserInteractionViewController
            self.navigationController?.pushViewController(userInteractionViewController, animated: true)
        }
    }
    
    @IBAction func signInWithGoogleButtonAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                // If sign in succeeded, display the app's main content View.
                if let signInResult = signInResult {
                    print("Signin Success")
                    UserDefaults.standard.set(true, forKey: "isSignInCompleted") //Bool
                    UserDefaults.standard.set(true, forKey: "isSignInCompletedWithGoogleAccount") //Bool
                    UserDefaults.standard.set(signInResult.user.profile?.givenName, forKey: "GoogleUserName") //setObject
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let userInteractionViewController = storyBoard.instantiateViewController(withIdentifier: "UserInteractionViewController") as! UserInteractionViewController
                    self.navigationController?.pushViewController(userInteractionViewController, animated: true)
                }
            }
        }
      }
    
    @IBAction func signInWithAppleButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func playWithoutLoginButtonAction(_ sender: Any) {
        //UserDefaults.standard.set(true, forKey: "isSignInCompleted") //Bool
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let userInteractionViewController = storyBoard.instantiateViewController(withIdentifier: "UserInteractionViewController") as! UserInteractionViewController
        self.navigationController?.pushViewController(userInteractionViewController, animated: true)

    }
    
    //SignOut
    @IBAction func signOut(sender: Any) {
        GIDSignIn.sharedInstance.signOut()
    }
}

