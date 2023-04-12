//
//  DragableImageView.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/27/23.
//

import SwiftUI
import AVFoundation
import Foundation

struct UserInteractionView: View {
    
    @ObservedObject var userInteractionViewModel = UserInteractionViewModel()
    @State var name: String = "User"
    @State var profileImageURL: URL = URL(fileURLWithPath: "")
    @State var colourArray: [CGColor] = [UIColor.white.cgColor, UIColor.red.cgColor, UIColor.black.cgColor, UIColor.yellow.cgColor, UIColor.systemBlue.cgColor]
       
    var body: some View {
        ZStack {
            VStack {
                //MARK: - SettingsView
                    VStack(alignment: .center) {
                        VStack {
                            //Speaker View
                            HStack {
                                Button(action: {
                                    userInteractionViewModel.updatedColour = colourArray.randomElement() ?? UIColor.black.cgColor
                                }){
                                    Text("  Change View Colour  ")
                                        .font(.system(size: 25))
                                        .bold()
                                        .background(Color.cyan)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5.0)
                                }
                                Spacer()
                                VStack(spacing: 5) {
                                    Button(action: {
                                        self.userInteractionViewModel.backgroundMusicIsEnabled.toggle()
                                        if userInteractionViewModel.backgroundMusicIsEnabled {
                                            MusicPlayer.shared.startBackgroundMusic()
                                        }
                                        else {
                                            MusicPlayer.shared.stopBackgroundMusic()
                                        }
                                    }) {
                                        Image(systemName:self.userInteractionViewModel.backgroundMusicIsEnabled ? "speaker" : "speaker.slash").resizable()
                                            .frame(width: 40,height: 40)
                                            .foregroundColor(.cyan)
                                    }
                                    Text("Music").bold().foregroundColor(.cyan)
                                }.padding(.trailing, 20)
                            }.padding(.all, 10)
                            
                        }.padding(.all,10)
                        Spacer()
                        //MARK: - Choose the move view
                        VStack(spacing: 10) {
                            HStack(alignment: .center, spacing: 20){
                                Text("  Choose your move  ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .background(Color.cyan)
                                    .foregroundColor(Color.white)
                                    .clipShape(Rectangle())
                                    .cornerRadius(5.0)
                            }
                            HStack(alignment: .center,spacing: 15) {
                                Spacer()
                                //Tapgesture for  Stone
                                Image("Stone")
                                    .resizable()
                                    .shadow(color: userInteractionViewModel.userSelectedElementInfoToShowShadow == "Stone" ? Color(UIColor.green) : Color(UIColor.clear), radius: 5.0)
                                    .frame(width: 100, height: 100)
                                    .onTapGesture{
                                        userTapOnElement(senderId: "Stone")
                                        refresh()
                                    }
                                Spacer()
                                //Tapgesture for  Paper
                                Image("Paper")
                                    .resizable()
                                    .shadow(color: userInteractionViewModel.userSelectedElementInfoToShowShadow == "Paper" ? Color(UIColor.green) : Color(UIColor.clear), radius: 5.0)
                                    .frame(width: 100, height: 100)
                                    //.clipShape(Circle())
                                    .onTapGesture {
                                        userTapOnElement(senderId: "Paper")
                                        refresh()
                                    }
                                Spacer()
                                //Tapgesture for  Scissor
                                Image("Scissor")
                                    .resizable()
                                    .shadow(color: userInteractionViewModel.userSelectedElementInfoToShowShadow == "Scissor" ? Color(UIColor.green) : Color(UIColor.clear), radius: 5.0)
                                    .frame(width: 100, height: 100)
                                    //.clipShape(Circle())
                                    .onTapGesture {
                                        userTapOnElement(senderId: "Scissor")
                                        refresh()
                                    }
                                Spacer()
                            }.padding(.all, 0)
                            
                        }
                        Spacer()
                        
                        //MARK: - User Point view
                        VStack(alignment: .center) {
                            VStack {
                                Text(" \(UserDefaults.standard.string(forKey: "GoogleUserName") ?? "User")'s Points: \(userInteractionViewModel.userPoint)  ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .background(Color.cyan)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5.0)
                                    .padding()
                                Text("  AI Points: \(userInteractionViewModel.appAIPoint)  ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .background(Color.cyan)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5.0)
                            }
                        }
                    }
                    .padding(.all, 10)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))

            }.padding(.all, 0)
                .background(Color(cgColor: userInteractionViewModel.updatedColour))
                    if (userInteractionViewModel.showAlert) && (userInteractionViewModel.whosePoint != "") {
                        VStack {
                            Spacer().frame(height: nil)
                            VStack(alignment: .center) {
                                HStack(alignment: .center) {
                                    Spacer()
                                    VStack {
                                        Image(userInteractionViewModel.randomlyAISelectedItem).resizable()
                                            .frame(width: 50,height: 100)
                                        Text("AI's Choice")
                                            .font(.system(size: 20))
                                            .bold()
                                            .background(Color.cyan)
                                            .foregroundColor(Color.white)
                                            .cornerRadius(5.0)
                                    }
                                    Spacer().foregroundColor(Color.white)
                                    Text(userInteractionViewModel.whosePoint == "Tie" ? "Tie" : userInteractionViewModel.whosePoint == "User" ? "You got +1 point" : "AI got +1 point")
                                        .font(.system(size: 20))
                                        .bold()
                                        .background(Color.cyan)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5.0)
                                    Spacer()
                                    VStack {
                                        Image(userInteractionViewModel.userSelectedItem).resizable()
                                            .frame(width: 50,height: 100)
                                        Text("Your's Choice")
                                            .font(.system(size: 20))
                                            .bold()
                                            .background(Color.cyan)
                                            .foregroundColor(Color.white)
                                            .cornerRadius(5.0)
                                    }
                                    Spacer()
                                }.padding(.all, 10)
                                .background((userInteractionViewModel.whosePoint == "User" ? Color.green : userInteractionViewModel.whosePoint == "Tie" ? Color.yellow : Color.red))
                                .padding([.trailing, .leading], 15)
                                    .cornerRadius(10)
                            }.padding([.trailing, .leading], 15)
                                .cornerRadius(10)
                                .background(.white)
                            Spacer().frame(height: nil)
                        }.padding(.all,0)
                        .background(.white)
                    }
        }
        .onAppear{
            userInteractionViewModel.backgroundMusicIsEnabled = false
            MusicPlayer.shared.stopBackgroundMusic()
        }
    }
    
    func userTapOnElement(senderId: String) {
        print(senderId)
        if let randomAISelectedElement = userInteractionViewModel.elementArray.randomElement() {
            //AI random element selection 
            userInteractionViewModel.randomlyAISelectedItem  = randomAISelectedElement
            userInteractionViewModel.appAISelectedElementInfoToShowShadow = randomAISelectedElement
            print("AI selected - \(userInteractionViewModel.randomlyAISelectedItem)")
            
            //User element selection
            userInteractionViewModel.userSelectedItem = senderId
            userInteractionViewModel.userSelectedElementInfoToShowShadow = senderId
            print("User selected - \(userInteractionViewModel.userSelectedItem)")
            
            // Stone element comparison
            if (userInteractionViewModel.userSelectedItem == "Stone") && (userInteractionViewModel.randomlyAISelectedItem == "Stone") {
                userInteractionViewModel.tieCount += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "Tie"
            }
            else if (userInteractionViewModel.userSelectedItem == "Stone") && (userInteractionViewModel.randomlyAISelectedItem == "Paper") {
                userInteractionViewModel.appAIPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "AI"
            }
            else if (userInteractionViewModel.userSelectedItem == "Stone") && (userInteractionViewModel.randomlyAISelectedItem == "Scissor") {
                userInteractionViewModel.userPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "User"
            }
            // Paper Element comparison
            else if (userInteractionViewModel.userSelectedItem == "Paper") && (userInteractionViewModel.randomlyAISelectedItem == "Paper") {
                userInteractionViewModel.tieCount += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "Tie"
            }
            else if (userInteractionViewModel.userSelectedItem == "Paper") && (userInteractionViewModel.randomlyAISelectedItem == "Scissor") {
                userInteractionViewModel.appAIPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "AI"
            }
            else if (userInteractionViewModel.userSelectedItem == "Paper") && (userInteractionViewModel.randomlyAISelectedItem == "Stone") {
                userInteractionViewModel.userPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "User"
            }
            // Scissor Element comparison
            else if (userInteractionViewModel.userSelectedItem == "Scissor") && (userInteractionViewModel.randomlyAISelectedItem == "Scissor") {
                userInteractionViewModel.tieCount += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "Tie"
            }
            else if (userInteractionViewModel.userSelectedItem == "Scissor") && (userInteractionViewModel.randomlyAISelectedItem == "Paper") {
                userInteractionViewModel.userPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "User"
            }
            else if (userInteractionViewModel.userSelectedItem == "Scissor") && (userInteractionViewModel.randomlyAISelectedItem == "Stone") {
                userInteractionViewModel.appAIPoint += 1
                userInteractionViewModel.showAlert = true
                userInteractionViewModel.whosePoint = "AI"
            }
            else {
                print("No element found")
            }
            
        }
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            userInteractionViewModel.showAlert = false
            userInteractionViewModel.whosePoint = ""
            userInteractionViewModel.randomlyAISelectedItem = ""
            userInteractionViewModel.userSelectedItem = ""
            userInteractionViewModel.userSelectedElementInfoToShowShadow = ""
            userInteractionViewModel.appAISelectedElementInfoToShowShadow = ""
            
        }
    }
}

struct UserInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        UserInteractionView()
    }
}

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "small-miracle", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
    func playSoundEffect(soundEffect: String) {
        if let bundle = Bundle.main.path(forResource: soundEffect, ofType: "mp3") {
            let soundEffectUrl = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:soundEffectUrl as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
