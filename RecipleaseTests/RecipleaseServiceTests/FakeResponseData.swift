//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Elodie gage on 15/02/20204
//    
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    
    static var recipleaseCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Reciplease", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let IncorrectData = "erreur".data(using: .utf8)
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    
    class ServiceError: Error {}
    static let error = ServiceError()
}
