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
    @Binding var isSignOutHappend: Bool
    @State var presentAlertToSignoutGoogleAccount: Bool = false
    @State var presentAlertToSignoutAppleAccount: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Spacer().frame(height: 40)
                Text("<- Go Back")
                    .font(.system(size: 20))
                    .bold()
                    .gradientForeground(colors: [.indigo, .cyan])
                    .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding(.top, 20)
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
                Spacer()
            }.padding(.all, 20)
                .edgesIgnoringSafeArea(.top) //or .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

