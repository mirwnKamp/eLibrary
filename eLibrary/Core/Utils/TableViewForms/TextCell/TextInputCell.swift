//
//  TextInputCell.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit
import SDWebImage

protocol TextInputCellDelegate: AnyObject {
    func cell(_ cell: TextInputCell, didTapWith value: Bool)
}

final class TextInputCell: UITableViewCell {

    private var titleLabel: UILabel = {
        let titleLabel = UILabel.newAutoLayoutView()
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 16)
        return titleLabel
    }()
    private var authorLabel: UILabel = {
        let authorLabel = UILabel.newAutoLayoutView()
        authorLabel.numberOfLines = 2
        authorLabel.font = .systemFont(ofSize: 14)
        return authorLabel
    }()
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel.newAutoLayoutView()
        descriptionLabel.numberOfLines = 4
        descriptionLabel.font = .systemFont(ofSize: 12)
        return descriptionLabel
    }()
    private var bookImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayoutView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        return imageView
    }()

    weak var delegate: TextInputCellDelegate?
    private var viewModel: TextInputViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGestureRecognizers()
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        selectionStyle = .none
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bookImageView.widthAnchor.constraint(equalToConstant: 120.0),
            bookImageView.heightAnchor.constraint(equalToConstant: 200.0), // Adjusted to fit common book dimensions

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor,constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 4),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8)
        ])
    }

    func configure(_ viewModel: TextInputViewModel) {
        self.viewModel = viewModel
        bookImageView.sd_setImage(with: viewModel.image)
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author.joined(separator: ", ")
        descriptionLabel.text = viewModel.desc

        contentView.backgroundColor = .white
    }

    private func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.cell(self, didTapWith: true)
        print("you tapped the book : \(titleLabel.text ?? "")")
    }
}
