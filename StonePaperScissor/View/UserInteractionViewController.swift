//
//  UserInteractionViewController.swift
//  StonePaperScissor
//
//  Created by Sreedhar Lakshmanan on 11/04/23.
//

import UIKit
import SwiftUI
import GoogleSignIn

struct GoogleLoggedInUserInfo {
    var name: String?
    var email:String?
    var image: URL?
}

class UserInteractionViewController: UIViewController {
    
    var googleLoggedInUserInfo: GoogleLoggedInUserInfo? = GoogleLoggedInUserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addDragableImageView()
       // googleUserInfo()
    }

    func addDragableImageView() {
        if let googleLoggedInUserInfo = googleLoggedInUserInfo {
            let childView = UIHostingController(rootView: UserInteractionView())
            addChild(childView)
            childView.view.frame = self.view.bounds
            self.view.addSubview(childView.view)
            self.view.backgroundColor = .black
            childView.didMove(toParent: self)
        }
    }
    
//    func googleUserInfo() {
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
//            guard error == nil else { return }
//            guard let signInResult = signInResult else { return }
//            let user = signInResult.user
//            let emailAddress = user.profile?.email
//            let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//        }
//    }

}
