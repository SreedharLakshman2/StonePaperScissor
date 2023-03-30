//
//  ViewController.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/24/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addDragableImageView()
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

