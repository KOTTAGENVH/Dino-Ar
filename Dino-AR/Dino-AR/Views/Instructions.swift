//
//  Instructions.swift
//  Dino-AR
//
//  Created by Nowen on 2024-05-19.
//

import SwiftUI

struct Instructions: View {
    var body: some View {
        ZStack {
            Image("wallpaper")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        .overlay(
            TabView {
                Instruction1view()
                    .tabItem {
                        Text("Step 1")
                    }
                Instruction2view()
                    .tabItem {
                        Text("Step 2")
                    }
            }
            .tabViewStyle(PageTabViewStyle())
        )
    }
}

#Preview {
    Instructions()
}
