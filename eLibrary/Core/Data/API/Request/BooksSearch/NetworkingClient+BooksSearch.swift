//
//  NetworkingClient+BooksSearch.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

extension NetworkingClient {
    static func booksSearch(query: String,index: Int, completion: @escaping (BooksResponse?) -> Void) {
        session.request(APIRouter
            .retrieveBooks(query: query, index: index))
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
