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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func setButtonImage(){
        let imgName = "Google"
        let image = UIImage(named: "\(imgName).png")!
        self.signInWithGoogleButtonOutlet.setImage(image, for: .normal)
    }
    @IBAction func signIn(sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            //guard error == nil else { return }
            
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                // If sign in succeeded, display the app's main content View.
                print("Signin Success")
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                    guard error == nil else { return }
                    guard let signInResult = signInResult else { return }
                    let user = signInResult.user
                    let emailAddress = user.profile?.email
                    let fullName = user.profile?.name
                    let givenName = user.profile?.givenName
                    let familyName = user.profile?.familyName
                    let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                }
            }
            
        }
    }
    
    //SignOut
    @IBAction func signOut(sender: Any) {
        GIDSignIn.sharedInstance.signOut()
    }
    
    
    //    UserDefaults.standard.set(true, forKey: "Key") //Bool
    //    UserDefaults.standard.set(1, forKey: "Key")  //Integer
    //    UserDefaults.standard.set("TEST", forKey: "Key") //setObject
    //    Retrieve
    //
    //     UserDefaults.standard.bool(forKey: "Key")
    //     UserDefaults.standard.integer(forKey: "Key")
    //     UserDefaults.standard.string(forKey: "Key")
    //    Remove
    //
    //     UserDefaults.standard.removeObject(forKey: "Key")
    //    Remove all Keys
    //
    //     if let appDomain = Bundle.main.bundleIdentifier {
    //    UserDefaults.standard.removePersistentDomain(forName: appDomain)
    //     }
}

