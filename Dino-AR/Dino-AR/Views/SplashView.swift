//
//  SplashView.swift
//  Dino-AR
//
//  Created by Nowen on 2024-05-17.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Image("AppIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }
}
