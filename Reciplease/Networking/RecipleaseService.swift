//
//  RecipleaseService.swift
//  Reciplease
//
//    Created by elodie gage on 15/02/2024.
//    
//

import Foundation
import Alamofire

class RecipleaseService {
    
    // MARK: - Properties
    
    private let session: Networking
    
    // MARK: - Initialization
    
    init(session: Networking = RecipleaseSession()) {
        self.session = session
    }
    
    // MARK: - Methods

    func request(from: Int, to: Int, ingredients: [String], completionHandler: @escaping (RecipleaseData?, Error?) -> Void) {
        
        guard let apiNumber = ApiConfiguration().apiNumber else { return }
        guard let url = URL(string: "https://api.edamam.com/search?&from=\(from)&to=\(to)&q=\(ingredients.joined(separator: ","))&app_id=\(apiNumber.apiId)&app_key=\(apiNumber.apiKey)") else { return }

        session.request(with: url) { data, error, response in
            if error != nil {
                return completionHandler(nil, ErrorCases.failure)
            }

            guard let r = response, r.statusCode == 200 else {
                return completionHandler(nil, ErrorCases.wrongResponse(statusCode: response!.statusCode))
            }

            guard let d = data else {
                return completionHandler(nil, ErrorCases.noData)
            }

            do {
                let result = try JSONDecoder().decode(RecipleaseData.self, from: d)
                return completionHandler(result, nil)
            } catch {
                return completionHandler(nil, ErrorCases.errorDecode)
            }
        }
    }
    
}
