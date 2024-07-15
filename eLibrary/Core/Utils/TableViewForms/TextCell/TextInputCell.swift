//
//  TextInputCell.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

protocol TextInputCellDelegate: AnyObject {
    func cell(_ cell: TextInputCell, didTapWith value: Bool)
}

final class TextInputCell: UITableViewCell {
    
    private let titleLabel = UILabel.newAutoLayoutView()
    
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
        fatalError("init(coder:) has not been implemented")    }
    
    private func commonInit() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func configure(_ viewModel: TextInputViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        contentView.backgroundColor = .white
    }
    
    private func setupGestureRecognizers() {
         let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
         longPressGestureRecognizer.minimumPressDuration = 0.01
         addGestureRecognizer(longPressGestureRecognizer)
     }
     
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            contentView.backgroundColor = .lightGray
        case .ended:
            contentView.backgroundColor = .white
            if gesture.location(in: self).y >= 0 && gesture.location(in: self).y <= bounds.height {
                delegate?.cell(self, didTapWith: true)
            }
        case .cancelled:
            contentView.backgroundColor = .white
        default:
            break
        }
    }
}
