//
//  DataEncoder.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import Foundation

protocol DataEncoderProtocol {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

final class DataEncoder: DataEncoderProtocol {
    private var jsonEncoder: JSONEncoder

    init(jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.jsonEncoder = jsonEncoder
    }

    func encode<T: Encodable>(_ value: T) throws -> Data {
        try jsonEncoder.encode(value)
    }
}

extension JSONEncoder: DataEncoderProtocol {}
