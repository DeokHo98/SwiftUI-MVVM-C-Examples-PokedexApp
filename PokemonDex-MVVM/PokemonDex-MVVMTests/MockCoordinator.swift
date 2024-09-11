//
//  MockCoordinator.swift
//  PokemonDex-MVVMTests
//
//  Created by Jeong Deokho on 9/11/24.
//

import SwiftUI
@testable import PokemonDex_MVVM

final class MockCoordinator: CoordinatorDependency {
    var path: NavigationPath = NavigationPath()
    var pushDestination: [AppDestination] = []
    var popedCount = 0
    
    func push(destination: AppDestination) {
        pushDestination.append(destination)
    }
    
    func pop() {
        popedCount += 1
    }
}
