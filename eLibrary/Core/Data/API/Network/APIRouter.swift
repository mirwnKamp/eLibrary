//
//  APIRouter.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    var encoder: DataEncoderProtocol {
        DataEncoder()
    }
    
    case retrieveBooks(query: String)
    
    var method: HTTPMethod {
        switch self {
        case .retrieveBooks: return .get
        }
    }
    
    var host: String {
        APIConstants.host
    }
    
    var scheme: String {
        APIConstants.scheme
    }
    
    var path: String {
        switch self {
        case .retrieveBooks: return "volumes"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .retrieveBooks(let query): return ["q": query, "maxResults": "20", "startIndex": "0"]
        }
    }
    
    var headers: [String: String] {
        [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = APIConstants.path + path
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw AFError.invalidURL(url: components.url!)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
