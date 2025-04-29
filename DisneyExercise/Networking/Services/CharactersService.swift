//
//  CharactersService.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//
import Foundation

protocol CharactersServiceProtocol: AnyObject {
    var serviceConfig: NetworkingConfigurable {get set}
    var serviceManagaer: ServiceManagerProtocol {get set}
    func fetch() async throws -> APIResponse
}

class CharactersService: CharactersServiceProtocol {
    
    func fetch() async throws -> APIResponse {
        let url = serviceConfig.baseURL
        let header = serviceConfig.header
        let timeInterval = TimeInterval(200)
        
        do {
            let result: APIResponse = try await serviceManagaer.fetch1(url: url, header: header, timeOut: timeInterval, httpMethod: .GET, body: nil)
            return result
        } catch {
            throw NSError(domain: "ServiceError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Error al realizar la solicitud: \(error.localizedDescription)"])
        }
    }
    
    var serviceConfig: NetworkingConfigurable
    var serviceManagaer: ServiceManagerProtocol
    
    init(serviceConfig: NetworkingConfigurable, serviceManagaer: ServiceManagerProtocol) {
        self.serviceConfig = serviceConfig
        self.serviceManagaer = serviceManagaer
    }
    
}
