//
//  HomeService.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 07/09/23.
//

import UIKit

enum NetworkError: Error {
    case invalidURL(url: String)
    case noData
    case invalidResponse
    case decodingError (Error)
    case networkFailure (Error)
}
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL (let ur1):
            return "URL inválida -> \(ur1)"
        case . noData:
            return "Dados não recebidos da API."
        case .invalidResponse:
            return "Resposta inválida da API."
        case .decodingError(let error):
            return "Decodificação falhou: \(error.localizedDescription)"
        case .networkFailure(let error):
            return "Falha na rede: \(error.localizedDescription)"
        }
    }
}

class HomeService: NSObject {
    
    func getPersonList(completion: @escaping (Result<PersonList,NetworkError>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/6a5c19b1-376d-455a-890b-42a52aae011b"
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                print("ERROR \(#function) DETALHE DO ERRO:\(error.localizedDescription)")
                completion(.failure(.networkFailure(error)))
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
                print("SUCESS -> \(#function)")
                completion(.success(personList))
            } catch {
                print("ERRO -> \(#function)")
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
