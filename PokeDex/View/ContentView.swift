//
//  ContentView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/17/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        if UserDefaults.standard.string(forKey: "loggedInUserEmail") != nil {
            HomeView()
        } else {
            StartView()
        }
    }
    
}

#Preview {
    ContentView()
}
