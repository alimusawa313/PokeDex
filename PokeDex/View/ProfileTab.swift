//
//  ProfileTab.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import SwiftData
import MBProgressHUD

struct ProfileTab: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router
    
    @State private var user: User?
    @State private var isLoggingOut = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if let user = user {
                Image("ash")
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                
                Text(user.name)
                    .font(.title)
                    .bold()
                
                Text(user.email)
                    .foregroundStyle(.secondary)
                
                Text(user.dob.formatted(date: .long, time: .omitted))
            } else {
                Text("Loading user data...")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            MainButton(title: "Logout", backgroundColor: .red, textColor: .white, action: {
                logout()
            })
        }
        .onAppear {
            fetchUserDetails()
        }
    }
    
    private func fetchUserDetails() {
        if let savedEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail")?.lowercased() {
            let fetchRequest = FetchDescriptor<User>(predicate: #Predicate { user in
                user.email == savedEmail
            })
            
            if let fetchedUser = try? modelContext.fetch(fetchRequest).first {
                user = fetchedUser
            }
        }
    }
    
    private func logout() {
        isLoggingOut = true
        UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
        user = nil
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = "Logging out..."
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                MBProgressHUD.hide(for: window, animated: true)
            }
            router.navigate(to: .start)
        }
    }
}

#Preview {
    ProfileTab()
}
