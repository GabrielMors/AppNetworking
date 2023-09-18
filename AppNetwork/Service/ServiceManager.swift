//
//  ServiceManager.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 17/09/23.
//

import Foundation

class ServiceManager: NetworkLayer {
    
    // Singleton
    static var shared: ServiceManager = ServiceManager()
    
    private var baseURL: String
    
    init(baseURL: String? = nil) {
        
        if let baseURL {
            self.baseURL = baseURL
                        // irá procurar no meu info.plist uma chave "BaseURL" e me retorna o valor
        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {
        // caso ele encontrar o valor, UTILIZE ela
            self.baseURL = baseURLString
        } else {
            self.baseURL = ""
        }
    }
    
    var session: URLSession = URLSession.shared
    
    func request<T>(with endPoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endPoint.url
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                if let error {
                    print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: data)
                    print("SUCCESS -> \(#function)")
                    completion(.success(object))
                } catch  {
                    print("ERROR -> \(#function)")
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}

