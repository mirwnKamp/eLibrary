//
//  DieldDataSource.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

protocol FieldDataSource: AnyObject {

    associatedtype Value
    associatedtype ViewModel

    var viewModel: ViewModel { get set }
    var value: Value { get set }
}
