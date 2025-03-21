//
//  Carousel.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI

struct Carousel: View {
    @Binding var currentIndex: Int
    
    let imageNames = ["1", "2", "3", "4", "5"]
    
    @State private var offset: CGFloat = 0
    @State private var timer: Timer?
    
    let imageWidth: CGFloat = 250
    let carouselWidth: CGFloat = 250 * 3
    let cardPadding: CGFloat = 30
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: cardPadding) {
                    ForEach(imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageWidth, height: 350)
                            .clipped()
                    }
                }
                .offset(x: offset)
                .onAppear {
                    startCarousel()
                }
            }
            .frame(width: carouselWidth, height: 350)
            .disabled(true)
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startCarousel() {
        // Timer to move the carousel every 3 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                // Update the current index for infinite scrolling
                currentIndex = (currentIndex + 1) % imageNames.count
                // Center the current image in the middle of the visible area
                offset = -CGFloat(currentIndex) * (imageWidth + cardPadding) + (carouselWidth - imageWidth) / 2
            }
        }
    }
}

