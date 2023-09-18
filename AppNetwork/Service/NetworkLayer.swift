//
//  NetworkLayer.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 17/09/23.
//

import Foundation

protocol NetworkLayer {
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}
