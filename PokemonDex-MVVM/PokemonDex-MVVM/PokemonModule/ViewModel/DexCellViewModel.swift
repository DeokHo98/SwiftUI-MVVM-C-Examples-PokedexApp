//
//  DexCellViewModel.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation
import SwiftUI

struct DexCellViewModel: Hashable {
    let id: Int
    let name: String
    let imageURL: String
    let typeName: String
    let backgroundColor: Color
    
    init(model: PokemonModel) {
        self.id = model.id
        self.name = model.name
        self.imageURL = model.imageURL
        self.typeName = model.type
        let backgroundColor: Color = switch model.type {
        case "fire": .red
        case "bug": .green
        case "poison": .init(uiColor: .darkGray)
        case "water": .blue
        case "electric": .yellow
        case "psychic": .purple
        case "normal": .orange
        case "ground": .gray
        case "flying": .teal
        case "fairy": .pink
        case "grass": .mint
        case "fighting": .brown
        case "steel": .init(uiColor: .lightGray)
        case "ice": .cyan
        case "rock": .brown
        case "dragon": .indigo
        default: .black
        }
        
        self.backgroundColor = backgroundColor
    }
}
