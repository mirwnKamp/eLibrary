//
//  UserManager.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 16/7/24.
//

import UIKit

final class UserManager {
    static let shared = UserManager()
    private init() {}
    
    var bookData: Book?
    
    func logout() {
        bookData = nil
    }
}

