//
//  PokemonEndPoint.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation

// MARK: - Case

enum PokemonEndPoint: NetworkEndPoint {
    case getDex
}

// MARK: - Path

extension PokemonEndPoint {
    var path: String {
        switch self {
        case .getDex:
            return "/pokemon.json"
        }
    }
}

// MARK: - Base URL

extension PokemonEndPoint {
    var baseURL: String {
        switch self {
        case .getDex:
            return Bundle.getNetwrokConstatns(key: .baseURL)
        }
    }
}

// MARK: - HTTP Method

extension PokemonEndPoint {
    var httpMethod: HTTPMethod {
        switch self {
        case .getDex:
            return .GET
        }
    }
}
