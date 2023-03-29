//
//  DragableImageView.swift
//  StonePaperScissor
//
//  Created by IFOCUS on 3/27/23.
//

import SwiftUI

struct UserInteractionView: View {
    
    @ObservedObject var userInteractionViewModel = UserInteractionViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                // AI_View
                    VStack {
                        HStack {
                            Spacer()
                            Text("AI Points: \(userInteractionViewModel.appAIPoint)")
                            Spacer()
                        }
                        Spacer()
                        if userInteractionViewModel.randomlyAISelectedItem != "" {
                            Image(userInteractionViewModel.randomlyAISelectedItem).resizable()
                                .frame(width: 100, height: 100)
                                .shadow(color: userInteractionViewModel.appAISelectedElementInfoToShowShadow != "" ? Color(UIColor.green) : Color(UIColor.clear), radius: 5.0)
                        }
                        Spacer()
                    }.padding(.all, 10)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .background(Color.white)

                // UserView
                    VStack(alignment: .center){
                        HStack {
                            Spacer()
                            Text("User Points: \(userInteractionViewModel.userPoint)")
                            Spacer()
                        }
                        Spacer()
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
                        }.padding(.all, 0)
                    }.padding(.all, 10)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .background(Color.white)

            }.padding(.all, 0)
            .background(Color.gray)
            
            if (userInteractionViewModel.showAlert) && (userInteractionViewModel.whosePoint != "") {
                VStack {
                    VStack(alignment: .center) {
                        Spacer()
                        HStack(alignment: .center) {
                            Spacer()
                            VStack {
                                Image(userInteractionViewModel.randomlyAISelectedItem).resizable()
                                    .frame(width: 50,height: 100)
                                Text("AI's Choice")
                            }
                            Spacer().foregroundColor(Color.white)
                            Text(userInteractionViewModel.whosePoint == "Tie" ? "Tie" : userInteractionViewModel.whosePoint == "User" ? "You got +1 point" : "AI got +1 point")
                                .bold()
                            Spacer()
                            VStack {
                                Image(userInteractionViewModel.userSelectedItem).resizable()
                                    .frame(width: 50,height: 100)
                                Text("Your's Choice")
                            }
                            Spacer()
                        }.padding(.all, 10)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .background(Color.gray)
                        
                        Spacer()
                    }.padding(.all, 0)
                }.padding(.all,0)
                .disabled(true)
                .background(Color.white)
               
            }
            
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

