//
//  Coordinator.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/11/24.
//

import SwiftUI

// MARK: - Destination

enum AppDestination: Hashable {
    case pokemonDexDetail(DexCellViewModel)
}

// MARK: - Coordinator

protocol CoordinatorDependency {
    var path: NavigationPath { get set }
    func push(destination: AppDestination)
    func pop()
}

@Observable
final class Coordinator: CoordinatorDependency {
   var path = NavigationPath()
    
    /// Adds the specified destination to the navigation path.
    func push(destination: AppDestination) {
        path.append(destination)
    }
    
    /// Removes the last destination from the current navigation path.
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    /// Returns the appropriate view for the given destination.
    func showScene(destination: AppDestination) -> some View {
        switch destination {
        case .pokemonDexDetail(let viewModel):
            DexDetailView(viewModel: viewModel).onDisappear {
                self.pop()
            }
        }
    }
}
