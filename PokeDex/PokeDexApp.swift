//
//  PokeDexApp.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/17/25.
//

import SwiftUI
import SwiftData

@main
struct PokeDexApp: App {
    
    @StateObject var router = Router()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .start:
                            StartView()
                                .environmentObject(router)
                        
                        case .login:
                            LoginView()
                                .environmentObject(router)
                        case .register:
                            RegisterView()
                                .environmentObject(router)
                        case .home:
                            HomeView()
                                .environmentObject(router)
                        case .pokemon(pokemon: let pokemon):
                            PokemonView(pokemon: pokemon)
                                .environmentObject(router)
                        }
                    }
                    .environmentObject(router)
            }
            .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
