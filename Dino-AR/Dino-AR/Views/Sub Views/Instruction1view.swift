//  Instruction1view.swift
//  Dino-AR
//
//  Created by Nowen on 2024-05-19.
//

import SwiftUI

struct Instruction1view: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.4)
                .blur(radius: 10)
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                Text("Instructions - 1")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 30)
                Text("Visit Dino-Ar Web")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // Open the hyperlink when clicked
                        if let url = URL(string: "https://dino-ar-web.vercel.app") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .padding(2)
                Text("Accept the T&C and choose start")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(2)
                Text("Point your camera to a marker ")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(2)
                Text("as the example below")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(2)
                Image("ar-example")
                    .resizable()
                    .scaledToFit()
                    .padding(2)
                Spacer()
            }
            .padding([.leading, .trailing], 16)
        }
    }
}

#Preview {
    Instruction1view()
}
