//
//  FormField.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

protocol FormFieldDelegate: AnyObject {
    func fieldDidTap(_ field: FormField)
}

protocol FormField: AnyObject {

    var key: String { get }
    var height: CGFloat { get }
    var delegate: FormFieldDelegate? { get set }

    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

extension FormField {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
