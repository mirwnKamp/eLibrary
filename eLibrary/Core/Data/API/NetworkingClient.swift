//
//  NetworkingClient.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import Alamofire
import Foundation

class NetworkingClient {
    static let shared = NetworkingClient()
    let retryLimit = 3
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 50
        configuration.timeoutIntervalForRequest = APIConstants.timeout
        let sess = Session(configuration: configuration, interceptor: NetworkingClient.shared)
        return sess
    }()

}

extension NetworkingClient: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = KeyChainManager.getAccessToken() else {
            completion(.success(urlRequest))
            return
        }
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("retry statusCode....\(statusCode)")
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        default:
            completion(.retry)
        }
    }
    
}

