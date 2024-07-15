//
//  BooksResponse.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

class BooksResponse: Decodable {
    var kind: String
    var totalItems: Int
    var items: [Book]
}

class Book: Decodable {
    var id: String
    var title: String
    var authors: [String]?
    var desc: String?
    var imurl: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case volumeInfo
        
        enum VolumeInfoKeys: String, CodingKey {
            case title
            case authors
            case desc = "description"
            case imurl = "imageLinks"
            case url = "infoLink"
        }
        
        enum ImageLinksKeys: String, CodingKey {
            case imurl = "thumbnail"
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let volumeInfoContainer = try container.nestedContainer(keyedBy: CodingKeys.VolumeInfoKeys.self, forKey: .volumeInfo)
        title = try volumeInfoContainer.decode(String.self, forKey: .title)
        authors = try? volumeInfoContainer.decode([String].self, forKey: .authors)
        desc = try? volumeInfoContainer.decode(String.self, forKey: .desc)
        url = try? volumeInfoContainer.decode(String.self, forKey: .url)
        
        if let imageLinksContainer = try? volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.ImageLinksKeys.self, forKey: .imurl) {
            imurl = try? imageLinksContainer.decode(String.self, forKey: .imurl)
        } else {
            imurl = nil
        }
    }
}
