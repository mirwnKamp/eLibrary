//
//  CustomUnderlinedButton.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

import UIKit

@IBDesignable open class CustomUnderlineButton: UIButton {
    var buttonRect = CGRect()
    
    var underlineColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var yRect: CGFloat = 9 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        buttonRect = rect
        updateUI()
    }
    
    open override func setNeedsDisplay(_ rect: CGRect) {
        updateUI()
    }
    
    func updateUI() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: buttonRect.height - yRect))
        path.addLine(to: CGPoint(x: buttonRect.width, y: buttonRect.height - yRect))
        path.lineWidth = 1
        tintColor = underlineColor
        tintColor.setStroke()
        path.stroke()
    }
}

