//
//  ViewController.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/24/23.
//

import UIKit
import SwiftUI
import GoogleSignIn
import AuthenticationServices
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var signInWithGoogleButtonOutlet: UIButton!
    @IBOutlet weak var signInWithAppleAccountButtonOutlet: UIButton!
    @IBOutlet weak var playWithOutSignIn: UIButton!
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-9471606055191983/3229282428"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        if UserDefaults.standard.bool(forKey: "isSignInCompleted") && UserDefaults.standard.bool(forKey: "isSignInCompletedWithAppleAccount") {
            
            
            if let userIdentifier = UserDefaults.standard.object(forKey: "appleUserIdentifier") as? String {
                let authorizationProvider = ASAuthorizationAppleIDProvider()
                authorizationProvider.getCredentialState(forUserID: userIdentifier) { (state, error) in
                    switch (state) {
                    case .authorized:
                        print("Account Found - Signed In")
                        DispatchQueue.main.async {
                            self.navigateTOUserInteractionView()
                        }
                        break
                    case .revoked:
                        print("No Account Found")
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(false, forKey: "isSignInCompleted") //Bool
                            UserDefaults.standard.set(false, forKey: "isSignInCompletedWithAppleAccount") //Bool
                            UserDefaults.standard.set("", forKey: "appleUserIdentifier")
                            UserDefaults.standard.set("", forKey: "AppleUserName") //setObject
                            // create the alert
                            let alert = UIAlertController(title: "Alert", message: "Apple Account revoked/SignedOut.", preferredStyle: UIAlertController.Style.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                        fallthrough
                    case .notFound:
                        print("No Account Found")
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(false, forKey: "isSignInCompleted") //Bool
                            UserDefaults.standard.set(false, forKey: "isSignInCompletedWithAppleAccount") //Bool
                            UserDefaults.standard.set("", forKey: "appleUserIdentifier")
                            UserDefaults.standard.set("", forKey: "AppleUserName") //setObject
                            // create the alert
                            let alert = UIAlertController(title: "Alert", message: "Apple Account not found.", preferredStyle: UIAlertController.Style.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    default:
                        break
                    }
                }
            }
            
            
        }
        else if UserDefaults.standard.bool(forKey: "isSignInCompleted") && UserDefaults.standard.bool(forKey: "isSignInCompletedWithGoogleAccount") {
            
            
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if error != nil || user == nil {
                    // Show the app's signed-out state.
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isSignInCompleted") //Bool
                        UserDefaults.standard.set(false, forKey: "isSignInCompletedWithGoogleAccount") //Bool
                        UserDefaults.standard.set("", forKey: "GoogleUserName") //Bool
                        
                        // create the alert
                        let alert = UIAlertController(title: "Alert", message: "Google Account info not found, Please login again.", preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    // Show the app's signed-in state.
                    self.navigateTOUserInteractionView()
                }
            }
        }
        else {
            return
        }
        
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .top,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
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
                    self.navigateTOUserInteractionView()
                }
            }
        }
    }
    
    @IBAction func signInWithAppleButtonAction(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    //added Interstitial Ad
    @IBAction func playWithoutLoginButtonAction(_ sender: Any) {
        navigateTOUserInteractionView()
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            
            let defaults = UserDefaults.standard
            defaults.set(userIdentifier, forKey: "appleUserIdentifier")
            
            //Save the UserIdentifier somewhere in your server/database
            
            UserDefaults.standard.set(true, forKey: "isSignInCompleted") //Bool
            UserDefaults.standard.set(true, forKey: "isSignInCompletedWithAppleAccount") //Bool
            UserDefaults.standard.set(appleIDCredential.fullName?.givenName, forKey: "AppleUserName") //setObject
            print(UserDefaults.standard.string(forKey: "AppleUserName"),"AppleUserName")
            navigateTOUserInteractionView()
            break
        default:
            break
        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    func navigateTOUserInteractionView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let userInteractionViewController = storyBoard.instantiateViewController(withIdentifier: "UserInteractionViewController") as! UserInteractionViewController
        self.navigationController?.pushViewController(userInteractionViewController, animated: true)
    }
}


