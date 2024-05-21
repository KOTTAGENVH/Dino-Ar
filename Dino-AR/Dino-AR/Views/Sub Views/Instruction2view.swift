//
//  Instruction2view.swift
//  Dino-AR
//
//  Created by Nowen on 2024-05-19.
//

import SwiftUI

struct Instruction2view: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.4)
                .blur(radius: 10)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Instructions - 2")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                HStack{
                    Text("To mute click this button ")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(2)
                    
                    Image(systemName: "speaker.slash.fill")
                        .foregroundColor(.black)
                    
                }
                HStack{
                    Text("To unmute click this button")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(2)
                    Image(systemName: "speaker.wave.3")
                        .foregroundColor(.black)
                }
                Text("Potrait mode is Recomended")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(2)
                Text("For demonstrations please subscribe")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(2)
                    .onTapGesture {
                        // Open the hyperlink when clicked
                        if let url = URL(string: "https://www.youtube.com/channel/UC5JyZl1fR8A3YRMXdXjtiZA") {
                            UIApplication.shared.open(url)
                        }
                    }
                Text("Contact developer")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(2)
                    .onTapGesture {
                        // Open the hyperlink when clicked
                        if let url = URL(string: "https://nowen-kottage.vercel.app/") {
                            UIApplication.shared.open(url)
                        }
                    }
                Spacer()
            }
            .padding([.leading, .trailing], 16)
        }
    }
}
#Preview {
    Instruction2view()
}
