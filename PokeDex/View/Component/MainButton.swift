//
//  MainButton.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI

struct MainButton: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(textColor)
                .bold()
                .frame(width: 300, height: 50)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

