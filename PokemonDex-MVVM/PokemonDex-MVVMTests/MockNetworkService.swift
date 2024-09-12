//
//  MockNetworkService.swift
//  PokemonDex-MVVMTests
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation
@testable import PokemonDex_MVVM

// MARK: - Mock Error

enum MockError: Error {
    case defaultError
}

extension MockError: LocalizedError {
    var errorDescription: String? {
        return "Mock Error Description"
    }
}

// MARK: - Mock NetworkService

final class MockNetworkService: NetworkServiceDependency {
    var model: Any?
    var error: MockError?
    
    func requestData<T: Decodable>(endPoint: NetworkEndPoint) async throws -> T {
        if let model = model as? T {
            return model
        }
        if let error {
            throw error
        }
        throw MockError.defaultError
    }
    
    func setModel(_ model: Any?) {
        self.model = model
    }
    
    func setError(_ error: MockError) {
        self.error = error
    }
}
