//
//  TextInputViewModel.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

struct TextInputViewModel {

    var title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
