//
//  HomeService.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 07/09/23.
//

import UIKit

class HomeService: NSObject {
    
//    func getPersonList(completion: @escaping (Result<PersonList,NetworkError>) -> Void) {
//
//        let urlString: String = "https://run.mocky.io/v3/6a5c19b1-376d-455a-890b-42a52aae011b"
//
//        guard let url: URL = URL(string: urlString) else {
//            completion(.failure(.invalidURL(url: urlString)))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let error {
//                    print("ERROR \(#function) DETALHE DO ERRO:\(error.localizedDescription)")
//                    completion(.failure(.networkFailure(error)))
//                }
//
//                guard let data else {
//                    completion(.failure(.noData))
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    completion(.failure(.invalidResponse))
//
//                    return
//                }
//
//                do {
//                    let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
//                    print("SUCESS -> \(#function)")
//                    completion(.success(personList))
//                } catch {
//                    print("ERRO -> \(#function)")
//                    completion(.failure(.decodingError(error)))
//                }
//            }
//        }
//        task.resume()
//    }
    
    func getPersonList(completion: @escaping (Result<[Person],NetworkError>) -> Void) {
        
        let urlString: String = "6a5c19b1-376d-455a-890b-42a52aae011b"
        
        let endPoint = Endpoint(url: urlString)
        
        ServiceManager.shared.request(with: endPoint, decodeType: PersonList.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.person))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}


















