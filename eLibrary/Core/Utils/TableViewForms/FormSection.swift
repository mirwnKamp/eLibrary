//
//  FormSection.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

final class FormSection {

    var key: String
    var header: FormHeader?
    var fields: [FormField]

    init(key: String, header: FormHeader? = nil, fields: [FormField]) {
        self.key = key
        self.header = header
        self.fields = fields
    }
}
