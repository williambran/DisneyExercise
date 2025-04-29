//
//  ServiceManager.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

import Foundation

protocol ServiceManagerProtocol: AnyObject {
    var urlSession: URLSession { get set }
    
    func fetch1<T: Decodable>(url: URL, header: [String:String],timeOut: TimeInterval, httpMethod: HTTPMethod,body: [String:String]?) async throws -> T
}

class ServiceManager: ServiceManagerProtocol {

    
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.init(configuration: .ephemeral) ){
        self.urlSession = urlSession
    }
    
    func fetch1<T>(url: URL, header: [String : String], timeOut: TimeInterval, httpMethod: HTTPMethod, body: [String : String]?) async throws -> T where T : Decodable {
        
        var urlRequest = URLRequest(url: url.absoluteURL)
        urlRequest.timeoutInterval = timeOut
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod.rawValue
        print("URL Request: \(urlRequest.url?.absoluteString)")

        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        print("Status got: \(httpResponse.statusCode)")
        
        guard let statusCode = ResponseStatusCode(rawValue: httpResponse.statusCode), statusCode == .successCode else {
            throw URLError(.badServerResponse)
        }
        print("Data: \(data)")

        if let model: T = parse(data: data) {
            return model
        } else {
            print("Errror cannotParseResponse")
            throw URLError(.cannotParseResponse)
        }
    }
    
    func parse<T:Decodable>(data: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error al decodificar: \(error.localizedDescription)")
            return nil
        }
    }

}
