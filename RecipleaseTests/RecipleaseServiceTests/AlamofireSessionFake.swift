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

    return completionHandler(data, error, response) }
}
