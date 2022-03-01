//
//  Network.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import Foundation
import Alamofire

class Network {
    public static let shared = Network()
    
    private let headers: HTTPHeaders = [
        "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
        "x-rapidapi-key": "e065cb2db9msh44f2e5f138d27b3p1413b6jsn9fbe941449ac"
    ]
    private let headURL = "https://wft-geo-db.p.rapidapi.com/v1"
    private let bodyURL = "/geo/countries"
    private let limitURL = "?limit=7"
    
    public func getCountries(_ completion: @escaping(DataModel?) -> Void) {
        let requestUrl = headURL + bodyURL + limitURL
        AF.request(requestUrl, method: .get, headers: headers).responseDecodable(of: DataModel.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getCountryDetails(countryCode: String, _ completion: @escaping(CountriesDetailViewModel?) -> Void) {
        let requestUrl = headURL + bodyURL + "/" + countryCode
        AF.request(requestUrl, method: .get, headers: headers).responseDecodable(of: CountriesDetailViewModel.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

