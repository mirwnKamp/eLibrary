//
//  NetworkingClient+BooksSearch.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

extension NetworkingClient {
    static func booksSearch(completion: @escaping (BooksResponse?) -> Void) {
        session.request(APIRouter
            .retrieveBooks)
        .validate()
        .responseDecodable(of: BooksResponse.self) { response in
            switch response.response?.statusCode {
            case 200:
                completion(response.value)
            case 400:
                completion(response.value)
            default:
                completion(nil)
            }
        }
    }
}
