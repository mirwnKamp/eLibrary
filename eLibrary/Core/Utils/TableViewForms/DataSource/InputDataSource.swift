//
//  FormHeader.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

protocol InputDataSource: AnyObject {

    associatedtype Item

    var dataSource: [Item] { get set }
}
