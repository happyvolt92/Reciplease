//
//  ErrorCases.swift
//  Reciplease
//
//  Created by Elodie gage on 15/02/20204
//    
//

import Foundation

enum ErrorCases: Swift.Error {
    case noData
    case wrongResponse(statusCode: Int?)
    case failure
    case errorDecode
}
