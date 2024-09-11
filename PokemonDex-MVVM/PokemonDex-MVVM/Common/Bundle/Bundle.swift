//
//  Bundle.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation

extension Bundle {
    /// Reads the specified plist file and returns its contents as a dictionary.
   private static func getPlistData(resource: String) -> [String: Any] {
          guard let path = Self.main.path(forResource: resource, ofType: "plist") else {
              return [:]
          }
          guard let data = FileManager.default.contents(atPath: path) else { return [:] }
          guard let plistData = try? PropertyListSerialization.propertyList(
              from: data,
              format: nil
          ) as? [String: Any] else { return  [:] }
          return plistData
      }
}

// MARK: - Network.plist

extension Bundle {
    enum Key: String {
        case baseURL
    }
    
    /// Retrieves a value from the Network.plist file based on the specified key.
    static func getNetwrokConstatns(key: Key) -> String {
        getPlistData(resource: "NetWork")[key.rawValue] as? String ?? ""
    }
}
