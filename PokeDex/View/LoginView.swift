//
//  LoginView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import SwiftData
import MBProgressHUD

struct LoginView: View {
    
    @EnvironmentObject var router: Router
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    @Environment(\.modelContext) private var modelContext
    
    func validateLogin() {
        let lowercaseEmail = email.lowercased()
        let fetchRequest = FetchDescriptor<User>(predicate: #Predicate { user in
            user.email == lowercaseEmail
        })
        
        
        if let user = try? modelContext.fetch(fetchRequest).first {
            if user.password == password {
                UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
                showLoginHUD()
            } else {
                errorMessage = "Incorrect password"
            }
        } else {
            errorMessage = "No user found with that email"
        }
    }
    
    private func showLoginHUD() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = "Logging in..."
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                MBProgressHUD.hide(for: window, animated: true)
            }
            UserDefaults.standard.set(email.lowercased(), forKey: "loggedInUserEmail")
            router.navigate(to: .home)
        }
    }
    
    var body: some View {
        ZStack {
            Image("pokBg")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 5, opaque: .random(in: 0...1) > 0.5)
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                
                TextField("Enter your email", text: $email)
                    .padding()
                    .keyboardType(.emailAddress)
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .padding(.horizontal)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                
                MainButton(title: "Login", backgroundColor: .blue, textColor: .white) {
                    validateLogin()
                }
                .padding(.top, 50)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
