//
//  ApiConfiguration.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//    
//

import Foundation

class ApiConfiguration {

    // get API Keys from ApiKeys.plist
    var apiNumber: ApiNumbers? {
        guard let path = Bundle.main.path(forResource: "ApiNumbers", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else { return nil }
        guard let dataApi = try? PropertyListDecoder().decode(ApiNumbers.self, from: data) else { return nil }
        return dataApi
    }
}

// structure to manage API Keys
struct ApiNumbers: Decodable {
    let apiId: String
    let apiKey: String
}
