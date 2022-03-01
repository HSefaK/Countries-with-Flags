//
//  CountriesDetailViewModel.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//


import Foundation

struct CountriesDetailViewModel: Codable {
    let data: CountryDetailModel?
}

struct CountryDetailModel: Codable {
    let capital, code, callingCode: String?
    let currencyCodes: [String]?
    let flagImageURI: String?
    let name: String?
    let numRegions: Int?
    let wikiDataID: String?

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
