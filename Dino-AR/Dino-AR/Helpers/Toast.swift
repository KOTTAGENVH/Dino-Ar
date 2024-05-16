//
//  Toast.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-16.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.red)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(20)
        }
        .opacity(isShowing ? 1 : 0)
        .animation(.easeInOut(duration: 0.2))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
}


