//
//  DragableImageView.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/27/23.
//

import SwiftUI
import AVFoundation
import Foundation

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .mask(self)
    }
}
struct UserInteractionView: View {
    
    @ObservedObject var userInteractionViewModel = UserInteractionViewModel()
    @State var name: String = "User"
    @State var profileImageURL: URL = URL(fileURLWithPath: "")
    @State var colourArray: [CGColor] = [UIColor.white.cgColor, UIColor.red.cgColor, UIColor.black.cgColor, UIColor.yellow.cgColor]
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
     var userName: String {
        var value: String = "Your"
        if (UserDefaults.standard.bool(forKey: "isSignInCompletedWithGoogleAccount")) {
            value = UserDefaults.standard.string(forKey: "GoogleUserName") ?? "Your"
        }
        else if (UserDefaults.standard.bool(forKey: "isSignInCompletedWithAppleAccount")) {
            value = UserDefaults.standard.string(forKey: "AppleUserName") ?? "Your"
        }
        else {
            value = "Your"
        }
        
        return value
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                VStack {
                    //MARK: - SettingsView
                    VStack(alignment: .center) {
                        Spacer().frame(height: 60)
                        //MARK: - Speaker and change colour action
                        
                        VStack {
                            HStack(spacing: 10) {
                                NavigationLink(destination: InfoView()) {
                                    Image(systemName: "info.square").resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(.indigo)
                                        .padding(.all)
                                }
                                Button(action: {
                                    userInteractionViewModel.updatedColour = colourArray.randomElement() ?? UIColor.black.cgColor
                                }){
                                    Text(" Change View Colour ")
                                        .font(.system(size: 15))
                                        .bold()
                                }.buttonStyle(GradientButtonStyle(colour1: Color.indigo, colour2: Color.cyan))
                                    .padding(.all)
                                VStack(spacing: 0) {
                                    Button(action: {
                                        self.userInteractionViewModel.backgroundMusicIsEnabled.toggle()
                                        if userInteractionViewModel.backgroundMusicIsEnabled {
                                            MusicPlayer.shared.startBackgroundMusic()
                                        }
                                        else {
                                            MusicPlayer.shared.stopBackgroundMusic()
                                        }
                                    }) {
                                        VStack(spacing: 5) {
                                            Image(systemName:self.userInteractionViewModel.backgroundMusicIsEnabled ? "speaker" : "speaker.slash").resizable()
                                                .frame(width: 20,height: 20)
                                                .foregroundColor(.white)
                                        }
                                    }.buttonStyle(GradientButtonStyle(colour1: Color.indigo, colour2: Color.cyan))
                                }.padding(.all)
                            }.padding(.all, 10)
                            
                        }.padding(.all,0)
                        
                        Spacer()
                        
                        //MARK: - Choose the move view
                        VStack(spacing: 10) {
                            HStack(alignment: .center, spacing: 20){
                                Text("  Choose your move  ")
                                    .font(.system(size: 30))
                                    .bold()
                                    .gradientForeground(colors: [.indigo, .cyan])
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
                                    .onTapGesture {
                                        userTapOnElement(senderId: "Scissor")
                                        refresh()
                                    }
                                Spacer()
                            }.padding(.all, 10)
                            
                        }.padding(.all, 0)
                        Spacer()
                        
                        //MARK: - User Point view
                        VStack(alignment: .center) {
                            VStack {
                                Text("\(userName)'s Points: \(userInteractionViewModel.userPoint) ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .gradientForeground(colors: [.indigo, .cyan])
                                    .padding()
                                Text("  AI's Points: \(userInteractionViewModel.appAIPoint)  ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .gradientForeground(colors: [.indigo, .cyan])
                            }
                        }
                    }
                    .padding(.all, 0)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    
                }.padding(.all, 0)
                    .background(Color(cgColor: userInteractionViewModel.updatedColour))
                if (userInteractionViewModel.showAlert) && (userInteractionViewModel.whosePoint != "") {
                    ZStack {
                        
                        VStack {
                            Spacer().frame(height: nil)
                            VStack(alignment: .center) {
                                Text("  Game Points: Best of \(userInteractionViewModel.gamePoint)  ")
                                    .font(.system(size: 25))
                                    .bold()
                                    .gradientForeground(colors: [.indigo, .cyan])
                                    .padding(.all, 15)
                                HStack(alignment: .center) {
                                    Spacer()
                                    VStack {
                                        Image(userInteractionViewModel.randomlyAISelectedItem).resizable()
                                            .frame(width: 50,height: 100)
                                        Text("AI's Choice")
                                            .font(.system(size: 15))
                                            .bold()
                                            .gradientForeground(colors: [.indigo, .cyan])
                                    }
                                    Spacer().foregroundColor(Color.white)
                                    Text(userInteractionViewModel.whosePoint == "Tie" ? "Tie" : userInteractionViewModel.whosePoint == "User" ? "You got +1 point" : "AI got +1 point")
                                        .font(.system(size: 15))
                                        .bold()
                                        .gradientForeground(colors: [.indigo, .cyan])
                                    Spacer()
                                    VStack {
                                        Image(userInteractionViewModel.userSelectedItem).resizable()
                                            .frame(width: 50,height: 100)
                                        Text("Your's Choice")
                                            .font(.system(size: 15))
                                            .bold()
                                            .gradientForeground(colors: [.indigo, .cyan])
                                        
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
                        //MARK: - Final view
                        if ((userInteractionViewModel.userPoint == userInteractionViewModel.gamePoint) || (userInteractionViewModel.appAIPoint == userInteractionViewModel.gamePoint)) && (userInteractionViewModel.showWinnerView) {
                            VStack(alignment: .center, spacing: 15) {
                                Spacer().frame(height: nil)
                                Image("Winner").resizable()
                                    .frame(width: 150, height:  150)
                                HStack {
                                    Spacer()
                                    Text("\(userInteractionViewModel.userPoint == userInteractionViewModel.gamePoint ? "  Congratulations you won!  " : "  AI Won!  ")")
                                        .font(.system(size: 30))
                                        .bold()
                                        .gradientForeground(colors: [.indigo, .cyan])
                                        .background(.white)
                                        .cornerRadius(5)
                                    Spacer()
                                }.padding(.all, 0)
                                Button(action: {
                                    userInteractionViewModel.userPoint = 0
                                    userInteractionViewModel.appAIPoint = 0
                                    userInteractionViewModel.whosePoint = ""
                                    userInteractionViewModel.tieCount = 0
                                    
                                    userInteractionViewModel.showAlert = false
                                    userInteractionViewModel.whosePoint = ""
                                    userInteractionViewModel.randomlyAISelectedItem = ""
                                    userInteractionViewModel.userSelectedItem = ""
                                    userInteractionViewModel.userSelectedElementInfoToShowShadow = ""
                                    userInteractionViewModel.appAISelectedElementInfoToShowShadow = ""
                                    userInteractionViewModel.showWinnerView = false
                                }) {
                                    Text("  CLOSE  ")
                                        .font(.system(size: 25))
                                        .bold()
                                        .cornerRadius(5)
                                }.buttonStyle(GradientButtonStyle(colour1: Color.red, colour2: Color.orange))
                                Spacer().frame(height: nil)
                            }.padding(.all, 0)
                                .background(.white)
                                .cornerRadius(15)
                        }
                    }
                    
                }
            }
            .onAppear{
                userInteractionViewModel.backgroundMusicIsEnabled = false
                MusicPlayer.shared.stopBackgroundMusic()
            }
            .edgesIgnoringSafeArea(.top) //or .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
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
        if (userInteractionViewModel.userPoint == userInteractionViewModel.gamePoint) || (userInteractionViewModel.appAIPoint == userInteractionViewModel.gamePoint) {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                userInteractionViewModel.showWinnerView = true
            }
        }
        else {
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

struct GradientButtonStyle: ButtonStyle {
    var colour1: Color?
    var colour2: Color?
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [colour1 ?? Color.indigo,colour2 ?? Color.cyan]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct GradientTextStyle: LabelStyle {
    var colour1: Color?
    var colour2: Color?
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.title
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [colour1 ?? Color.indigo,colour2 ?? Color.cyan]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
