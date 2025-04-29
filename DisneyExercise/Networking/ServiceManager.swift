//
//  ServiceManager.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

import Foundation

protocol ServiceManagerProtocol: AnyObject {
    var urlSession: URLSession { get set }
    
    func fetch<T: Decodable>(url: URL, header: [String:String],timeOut: TimeInterval, httpMethod: HTTPMethod,body: [String:String]?,  result: @escaping ( _ response: Result<T,ErrorResponse> )-> Void )
    
    func fetch1<T: Decodable>(url: URL, header: [String:String],timeOut: TimeInterval, httpMethod: HTTPMethod,body: [String:String]?) async throws -> T
    
    func dowloadResources(from url: String) async throws -> Data

}

class ServiceManager: ServiceManagerProtocol {

    
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.init(configuration: .ephemeral) ){
        self.urlSession = urlSession
    }
    
    
    func fetch<T>(url: URL, header: [String : String], timeOut: TimeInterval, httpMethod: HTTPMethod, body: [String : String]?, result: @escaping (Result<T, ErrorResponse>) -> Void) where T : Decodable {
        
        var urlRequest = URLRequest(url: url.absoluteURL)
        urlRequest.timeoutInterval = timeOut
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod.rawValue
        
        urlSession.dataTask(with: urlRequest) { (data,response,error) in
            
            let response = response as? HTTPURLResponse
            guard let httpRespnse = response, let statusMannaged = ResponseStatusCode(rawValue: httpRespnse.statusCode) else {
                result(.failure(.Generic))
                return
            }
            DispatchQueue.main.async {
                switch statusMannaged {
                case .successCode:
                    self.handlerSucccesRequest(data: data, statusCode: statusMannaged, error: error, completion: result)
                case .badRequest:
                    result(.failure(.Generic))
                case  .notFound:
                    result(.failure(.Generic))
                case .errorRequest:  result(.failure(.Generic))
                    //result(.noSuccess(error: self.parseError(errorCode: statusMannaged)))
                case .internalServerError:
                    result(.failure(.Generic))
                case .unauthorizedCode:  result(.failure(.Generic))
                    //result(.noSuccess(error: self.parseError(errorCode: statusMannaged)))
                }
                
            }
            
        }.resume()
        
    }
    
    func fetch1<T>(url: URL, header: [String : String], timeOut: TimeInterval, httpMethod: HTTPMethod, body: [String : String]?) async throws -> T where T : Decodable {
        
        var urlRequest = URLRequest(url: url.absoluteURL)
        urlRequest.timeoutInterval = timeOut
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod.rawValue
        print("Vamos a pedir datos: \(urlRequest.url?.absoluteString)")


        let (data, response) = try await urlSession.data(for: urlRequest)
        
        print("No estamos opteniendo nada", response)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        print("Status obtenido: \(httpResponse.statusCode)")
        
        guard let statusCode = ResponseStatusCode(rawValue: httpResponse.statusCode), statusCode == .successCode else {
            throw URLError(.badServerResponse)
        }
        print("Data obtenido: \(data)")

        if let model: T = parse(data: data) {
            return model
        } else {
            print("Errror cannotParseResponse")
            throw URLError(.cannotParseResponse) // Lanzamos error si la decodificación falla
        }

    }
    
    private func handlerSucccesRequest<T: Decodable>(data: Data?, statusCode: ResponseStatusCode, error: Error?, completion: @escaping(Result<T, ErrorResponse>)->()) {

        if let data = data {
            if let model: T = parse(data: data) {
                completion(.success(model))
            } else {
                completion(.failure(.Generic))
            }

        } else {
            completion(.failure(.Generic))
        }
    }
    
    func parse<T:Decodable>(data: Data) -> T? {
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Respuesta JSON como String: \(jsonString)") // Esto te permitirá ver el JSON en consola
        } else {
            print("No se pudo convertir los datos a String.")
        }
        do {
            print("Tipo que quiero:", T.self)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error al decodificar: \(error.localizedDescription)") // Para mostrar qué error ocurrió
            return nil
        }

    }
    
    func dowloadResources(from url: String) async throws -> Data {
        guard let imageURL = URL(string: url) else { throw NSError(domain: "HomeRepositoryError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "URL no válida"]) }

        do {
            let (data, _) = try await urlSession.data(from: imageURL)
            return data
        } catch {
            print("Error al descargar la imagen: \(error)")
            throw NSError(domain: "HomeRepositoryError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Error al descargar la imagen"])
        }
    }
}
