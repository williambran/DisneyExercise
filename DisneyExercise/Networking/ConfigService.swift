//
//  ConfigService.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//
import Foundation

protocol NetworkingConfigurable {
    var baseURL: URL { get }
    var endPoint: String { get }
    var header: [String:String] { get }
    var queryParameters: [String: String] { get }
    
}

struct ConfigService: NetworkingConfigurable {
    var baseURL: URL
    var endPoint: String
    var header: [String : String]
    var queryParameters: [String : String]
    
}

enum HTTPMethod: String {
case GET,POST,PUT
}

enum ResponseStatusCode: Int {
    case successCode = 200
    case badRequest = 400
    case unauthorizedCode = 401
    case notFound = 404
    case internalServerError = 500
    case errorRequest
    
    
    static func getStatusForCode(_ rawValue: Int) -> ResponseStatusCode {
        switch rawValue {
        case 200: return .successCode
        case 201: return .successCode
        case 400: return .badRequest
        case 401: return .unauthorizedCode
        case 404: return .notFound
        case 500: return .internalServerError
        default:
            return .errorRequest
        }
    }
}

