//
//  TextInputFormField.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

final class TextInputFormField {

    let key: String
    var viewModel: TextInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: TextInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

// MARK: - FormField
extension TextInputFormField: FormField {

    var height: CGFloat { 160 }

    func register(for tableView: UITableView) {
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
        cell.delegate = self
        cell.configure(viewModel)
        return cell
    }
}

// MARK: - FieldDataSource
extension TextInputFormField: FieldDataSource {

    var value: Bool {
        get {
            viewModel.isSelected
        }
        set {
            viewModel.isSelected = newValue
        }
    }
}

// MARK: - TextInputCellDelegate
extension TextInputFormField: TextInputCellDelegate {

    func cell(_ cell: TextInputCell, didTapWith value: Bool) {
        viewModel.isSelected = value
        delegate?.fieldDidTap(self)
    }
}
