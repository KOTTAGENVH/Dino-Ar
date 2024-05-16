//
//  ContentView.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-14.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var  isMute = false
    @State private var isCheckboxChecked = false
    @State private var showToast = false

    var body: some View {
        NavigationView {
            ZStack {
                      Image("wallpaper2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            if (isMute == false){
                                // Play the background sound when ContentView appears
                                playSound(sound: "Home-Background", type: "mp3")
                            }
                        }
                VStack {
                    Spacer()
//                    Spacer()
                    HStack {
                        NavigationLink(destination: Markerview().onAppear{
                            stopSound()
                        }) {
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.white.opacity(0.3)))
                                .cornerRadius(20)
                        }
                        .padding(.top, 50)
                        NavigationLink(destination: Markerview().onAppear{
                            stopSound()
                        }) {
                            Text("Start")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.white.opacity(0.3)))
                                .cornerRadius(20)
                        }
                        .padding(.top, 50)
                        .disabled(!isCheckboxChecked)
                        .onTapGesture {
                                                if !isCheckboxChecked {
                                                    showToast = true
                                                }
                                            }
                    }
                    .padding()
                    
                    HStack {
                        Spacer().frame(width: 10)
                          
                          Toggle(isOn: $isCheckboxChecked) {
                              Text("I accept the terms and conditions")
                                  .foregroundColor(.white)
                                  .onTapGesture {
                                      // Open the hyperlink when clicked
                                      if let url = URL(string: "https://www.apple.com") {
                                          UIApplication.shared.open(url)
                                      }
                                  }
//                                  .padding(.top, 20)
                              
                          }
                          .padding()
                          .onTapGesture {
                                    showToast = false
                                        }
                                              
                        Spacer().frame(width: 10)
                      }

                      Spacer()
                    Button(action: {
                        isMute.toggle()
                           if isMute {
                               stopSound()
                           } else {
                               playSound(sound: "Home-Background", type: "mp3")
                           }
                    }) {
                        if isMute == false {
                            SpeakerIcon()
                           } else {
                               MuteIcon()
                           }
                    }

                }
                ToastView(message: "Please accept the Terms & Conditions", isShowing: $showToast)
                                   .padding(.horizontal)
                                   .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                   .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                                   .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
}


#Preview {
    ContentView()
}
