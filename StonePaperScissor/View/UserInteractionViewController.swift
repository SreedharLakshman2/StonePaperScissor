//
//  UserInteractionViewController.swift
//  StonePaperScissor
//
//  Created by Sreedhar Lakshmanan on 11/04/23.
//

import UIKit
import SwiftUI

class UserInteractionViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addDragableImageView()
       // googleUserInfo()
    }

    func addDragableImageView() {
            let childView = UIHostingController(rootView: UserInteractionView())
            addChild(childView)
            childView.view.frame = self.view.bounds
            self.view.addSubview(childView.view)
            self.view.backgroundColor = .black
            childView.didMove(toParent: self)
    }
    

}
