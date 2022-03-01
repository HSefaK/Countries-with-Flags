//
//  HomeViewModel.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import Foundation

struct DataModel: Codable {
    let data: [CountryModal]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct CountryModal: Codable {
    let code: String
    let name: String
    let wikiDataId: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case wikiDataId
    }
}
