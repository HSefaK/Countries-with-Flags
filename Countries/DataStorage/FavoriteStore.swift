//
//  FavoriteStore.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import Foundation

class FavoriteStore {
    
    static let userPreferences = UserDefaults.standard
    
    static var favorites: [String]? {
        get {
            return userPreferences.stringArray(forKey: "favoritesKey")
        } set(newValue) {
            userPreferences.set(newValue, forKey: "favoritesKey")
        }
    }
    
}
