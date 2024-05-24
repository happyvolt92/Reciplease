//
//  RecipleaseSession.swift
//  Reciplease
//
//  Created by Elodie gage on 15/02/20204
//    
//

import Foundation
import Alamofire

    // MARK: - Protocol Networking and class RecipleaseSession

protocol Networking {
        
    func request(with url: URL, completionHandler: @escaping (Data?, Error?, HTTPURLResponse?) -> Void)
}

final class RecipleaseSession: Networking {
        
    func request(with url: URL, completionHandler: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
        AF.request(url).responseData { (response: AFDataResponse<Data>) in
            completionHandler(response.data, response.error, response.response)
        }
    }
}
