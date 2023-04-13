//
//  infoView.swift
//  StonePaperScissor
//
//  Created by Sreedhar Lakshmanan on 13/04/23.
//

import SwiftUI
import GoogleSignIn
import UIKit

struct InfoView: View {
    
    var defaults =  UserDefaults.standard
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Spacer().frame(height: 40)
                Text("Other apps from us").font(.system(size: 30))
                    .bold()
                
                HStack(spacing: 10) {
                    Button(action: {
                        if let appStoreURL = URL(string: "https://itunes.apple.com/us/app/apple-store/id6446313196") {
                            UIApplication.shared.open(appStoreURL)
                        }
                    }){
                        VStack {
                            Image("KolourPencil").resizable().frame(width: 30,height: 30)
                            Text("KolourPencil")
                                .font(.system(size: 15))
                                .bold()
                        }
                        
                    }.buttonStyle(GradientButtonStyle(colour1: Color.indigo, colour2: Color.cyan))
                    
                    Button(action: {
                        if let appStoreURL = URL(string: "https://itunes.apple.com/us/app/apple-store/id6446448645") {
                            UIApplication.shared.open(appStoreURL)
                        }
                    }){
                        VStack {
                            Image("Speedymeter").resizable().frame(width: 30,height: 30)
                            Text("Speedymeter")
                                .font(.system(size: 15))
                                .bold()
                        }
                    }.buttonStyle(GradientButtonStyle(colour1: Color.indigo, colour2: Color.cyan))
                    Spacer()
                }
                if (defaults.bool(forKey: "isSignInCompleted") && (defaults.bool(forKey: "isSignInCompletedWithGoogleAccount"))) {
                     Button(action: {
                         GIDSignIn.sharedInstance.signOut()
                         UserDefaults.standard.set(false, forKey: "isSignInCompleted") //Bool
                         UserDefaults.standard.set(false, forKey: "isSignInCompletedWithGoogleAccount")
                         UserDefaults.standard.set("", forKey: "GoogleUserName")
                         self.presentationMode.wrappedValue.dismiss()
                    }){
                        VStack {
                            Text("SignOut")
                                .font(.system(size: 15))
                                .bold()
                        }
                    }.buttonStyle(GradientButtonStyle(colour1: Color.red, colour2: Color.red))
                }
                Spacer()
                Text("<- Go Back")
                    .font(.system(size: 20))
                    .bold()
                    .gradientForeground(colors: [.indigo, .cyan])
                    .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding(.all, 10)
            }.padding(.all, 20)
                .edgesIgnoringSafeArea(.top) //or .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
