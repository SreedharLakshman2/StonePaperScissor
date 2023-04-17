//
//  ViewController.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/24/23.
//

import UIKit
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var playWithOutSignIn: UIButton!
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // In this case, we instantiate the banner with desired ad size.
        addCornerRadiusTo(button: playWithOutSignIn)

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-9471606055191983/3229282428"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func addCornerRadiusTo(button: UIButton) {
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Task {
            _ =  await ATT.permissionRequest()
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
    
    func navigateTOUserInteractionView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let userInteractionViewController = storyBoard.instantiateViewController(withIdentifier: "UserInteractionViewController") as! UserInteractionViewController
        self.navigationController?.pushViewController(userInteractionViewController, animated: true)
    }
}


struct ATT {
    private init() {}
   
    static func permissionRequest() async -> Bool {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .notDetermined:
            await ATTrackingManager.requestTrackingAuthorization()
            return ATTrackingManager.trackingAuthorizationStatus == .authorized
        case .restricted, .denied:
            return false
        case .authorized:
            return true
        @unknown default:
            fatalError()
        }
    }
}

extension UIView {

    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }


    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
