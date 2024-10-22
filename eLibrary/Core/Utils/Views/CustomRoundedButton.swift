//
//  CustomRoundedButton.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

import UIKit

@IBDesignable final class CustomRoundedButton: UIButton {
    private var heightConstant = 49.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        editButtonStyle()
        setTitleColor(titleColor, for: .normal)
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }

    // MARK: - local properties
    private var type: ButtonStyle = .light
    
    // MARK: - inspectable(s)
    @IBInspectable var imageName: String = "" {
        didSet {
            setImage(UIImage(named: imageName), for: state)
        }
    }
    
    /// Button text title color
    @IBInspectable var titleColor: UIColor? {
        get {
            return self.titleColor(for: .normal)
        }
        set {
            if let color = newValue {
                setTitleColor(color, for: .normal)
            } else {
                setTitleColor(.white, for: .normal)
            }
        }
    }

    /// Represent `ButtonStyle` enum
    @IBInspectable public var buttonStyle: Int {
        get {
            return type.rawValue
        }
        set(buttonType) {
            type = ButtonStyle(rawValue: buttonType) ?? .light
            editButtonStyle()
        }
    }

    @IBInspectable var fontSize: CGFloat = 16 {
        willSet(newValue) {
            titleLabel?.font = .systemFont(ofSize: fontSize)
        }
    }

    // MARK: - overrides
    /// The background color when button enabled
    public override var isEnabled: Bool {
        didSet {
            let color = isEnabled ? enabledColor : disabledColor
            guard let buttonColor = color else {
                editButtonStyle()
                return
            }
            layer.borderWidth = 0
            backgroundColor = buttonColor
        }
    }
    /// `isHighlighted` status change button appearance depends on it's style and background
    public override var isHighlighted: Bool {
        didSet {
            editButtonStyle()
        }
    }

    /// The button style
    public enum ButtonStyle: Int {
        case light
        case dark
    }

    /// The background color when button enabled
    public var enabledColor: UIColor? {
        willSet {
            if isEnabled == true {
                backgroundColor = newValue
            }
        }
    }

    /// The background color when button disabled
    public var disabledColor: UIColor? {
        willSet {
            if isEnabled == false {
                backgroundColor = newValue
            }
        }
    }

    // MARK: - private methods
    private func editButtonStyle() {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 24
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        switch type {
        case .light:
            backgroundColor = isEnabled ? .customRoundedButtonLightBgColor : .customRoundedButtonLightBgColor.withAlphaComponent(0.6)
            setTitleColor(.black, for: .normal)
        case .dark:
            backgroundColor = isEnabled ? .purpleCustom : .purpleCustom.withAlphaComponent(0.6)
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
        }
    }
}

private extension UIColor {
    static let customRoundedButtonLightBgColor = UIColor(named: "customRoundedButtonLightBgColor") ?? .white
    static let customRoundedButtonGrayColor = UIColor(named: "customRoundedButtonGrayColor") ?? .white
}
