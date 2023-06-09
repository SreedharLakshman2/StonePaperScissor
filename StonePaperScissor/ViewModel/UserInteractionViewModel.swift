//
//  UserInteractionView.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/27/23.
//

import Foundation
import CoreGraphics
import UIKit

class UserInteractionViewModel: ObservableObject {
    
    @Published var elementArray = ["Stone","Paper","Scissor"]
    @Published var randomlyAISelectedItem = ""
    @Published var userSelectedItem = ""
    @Published var userPoint: Int = 0
    @Published var appAIPoint: Int = 0
    @Published var tieCount: Int = 0
    @Published var userSelectedElementInfoToShowShadow: String = ""
    @Published var appAISelectedElementInfoToShowShadow: String = ""
    @Published var showAlert: Bool = false
    @Published var whosePoint: String = ""
    
    @Published var isPlayerEnteredName: Bool = false
    @Published var playerName: String = ""
    @Published var backgroundMusicIsEnabled: Bool = true
    @Published var changeViewColour:Bool = false
    @Published var updatedColour: CGColor = UIColor.black.cgColor
    @Published var gamePoint: Int = 3
    @Published var showWinnerView: Bool = false
    @Published var presentInfoView: Bool = false
    
    
}
