//
//  RequestBuilder.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 18/09/23.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest
}
