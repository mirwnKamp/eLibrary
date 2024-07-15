//
//  TitleHeaderFooterView.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

struct TitleHeaderFooterViewModel {

    let title: String
}

final class TitleHeaderFooterView: UITableViewHeaderFooterView {

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    func configure(with viewModel: TitleHeaderFooterViewModel) {
        titleLabel.text = viewModel.title
    }
}

// MARK: - Private helper

extension TitleHeaderFooterView {

    private func setUpView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)

        titleLabel.textColor = .systemGray
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
    }
}
