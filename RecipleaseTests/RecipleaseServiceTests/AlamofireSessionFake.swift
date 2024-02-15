//
//  AlamoFireSessionFake.swift
//  RecipleaseTests
//
//  Created by Elodie gage on 15/02/20204
//    
//

import Foundation
import Alamofire
@testable import Reciplease

class AlamofireSessionFake: Networking {
    
    // MARK: - Properties
    
    var data: Data?
    var response: HTTPURLResponse?
    var error: Swift.Error?
    
    // MARK: - Initialization
    
    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    // MARK: - Method
    
    func request(with url: URL, completionHandler: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
//        if let error = self.error {
//            return completionHandler(nil, error)
//        }
//
//        guard let response = response, response.statusCode == 200 else {
//            return completionHandler(nil, ErrorCases.wrongResponse(statusCode: self.response?.statusCode))
//        }
//
//        guard let data = data else {
//            return completionHandler(nil, ErrorCases.noData)
//        }
//
//        do {
//            let result = try JSONDecoder().decode(RecipleaseData.self, from: data)
//            return completionHandler(result, nil)
//        } catch {
//            return completionHandler(nil, ErrorCases.errorDecode)
//        }
    return completionHandler(data, error, response) }
}
