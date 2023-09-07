//
//  HomeService.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 07/09/23.
//

import UIKit

class HomeService: NSObject {

    func getPersonList() {
        let urlString: String = "https://run.mocky.io/v3/6a5c19b1-376d-455a-890b-42a52aae011b"
        
        guard let url: URL = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error {
                print("ERROR \(#function) DETALHE DO ERRO:\(error.localizedDescription)")
            }
            
            guard let data else {
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                return
            }
            
            do {
                
            } catch {
                
            }
        }
        task.resume()
    }
}
