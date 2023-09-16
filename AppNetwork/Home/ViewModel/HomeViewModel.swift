//
//  HomeViewModel.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 07/09/23.
//

import Foundation

class HomeViewModel: NSObject {
    
    var service: HomeService = HomeService()
    
    public func fetchRequest() {
        service.getPersonList { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.errorDescription ?? "")
            }
        }
    }
}
