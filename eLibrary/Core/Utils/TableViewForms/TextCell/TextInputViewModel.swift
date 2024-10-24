//
//  TextInputViewModel.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import Foundation

struct TextInputViewModel {

    var bookData: Book
    var title: String
    var desc: String
    var author: [String]
    var image: URL
    var isSelected: Bool

    init(bookData: Book, title: String, author: [String], desc: String, image: URL, isSelected: Bool = false) {
        self.bookData = bookData
        self.title = title
        self.author = author
        self.desc = desc
        self.image = image
        self.isSelected = isSelected
    }
}
