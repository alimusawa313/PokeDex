//
//  RegisterView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import SwiftData
import MBProgressHUD

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var dob = Date()
    
    @State private var showingDatePicker = false
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    
    func registerUser() {
        withAnimation {
            let newItem = User(name: name, email: email.lowercased(), password: password, dob: dob)
            modelContext.insert(newItem)
            
            UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
            showLoginHUD()
        }
    }
    
    private func showLoginHUD() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = "Creating Account..."
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
                
                Text("Create New Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                
                TextField("Enter your name", text: $name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .padding(.horizontal)
                
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .padding(.horizontal)
                
                Button(action: {
                    showingDatePicker.toggle()
                }) {
                    HStack {
                        Text("Select Date of Birth").foregroundStyle(.gray)
                        Spacer()
                        Text(dob, style: .date)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.thinMaterial))
                    .padding(.horizontal)
                }
                
                
                MainButton(title: "Register", backgroundColor: .blue, textColor: .white) {
                    registerUser()
                    
                }
                .padding(.top, 50)
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showingDatePicker) {
                VStack {
                    Text("Select your date of birth")
                        .font(.title)
                        .padding()
                    
                    DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    
                    Button("Done") {
                        showingDatePicker.toggle()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
            }
        }
    }
}

#Preview {
    RegisterView()
}
