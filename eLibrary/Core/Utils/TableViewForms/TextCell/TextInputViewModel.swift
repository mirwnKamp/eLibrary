//
//  TextInputViewModel.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import Foundation

struct TextInputViewModel {

    var title: String
    var desc: String
    var author: [String]
    var image: URL
    var isSelected: Bool

    init(title: String, author: [String], desc: String, image: URL, isSelected: Bool = false) {
        self.title = title
        self.author = author
        self.desc = desc
        self.image = image
        self.isSelected = isSelected
    }
}
