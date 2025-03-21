//
//  StartView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI

struct StartView: View {
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image("\(currentIndex + 1)")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 10)
            
            VStack {
                Image("textlogo")
                    .resizable()
                    .frame(width: 300, height: 150)
                
                Carousel(currentIndex: $currentIndex)
                
                Spacer()
                
                MainButton(
                    title: "Login",
                    backgroundColor: .red,
                    textColor: .white,
                    action: {
                        
                    }
                )
                
                MainButton(
                    title: "Create Account",
                    backgroundColor: .white,
                    textColor: .red,
                    action: {
                        
                    }
                )
                
                
            }
        }
    }
}

#Preview {
    StartView()
}

