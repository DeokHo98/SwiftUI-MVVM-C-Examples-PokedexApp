//
//  PokemonDex_MVVMApp.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import SwiftUI

@main
struct PokemonDex_MVVMApp: App {
    
   @State private var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                DexView(viewModel: DexViewModel(coordinator: self.coordinator))
                    .navigationDestination(for: AppDestination.self) { destination in
                        coordinator.showScene(destination: destination)
                    }
            }
            .accentColor(.black)
        }
    }
}
