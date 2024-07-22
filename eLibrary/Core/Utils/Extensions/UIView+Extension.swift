//
//  UIView+Extension.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }
    
    func fround(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func addShadow(color: UIColor = .black,
                   offset: CGSize = CGSize(width: 0, height: 1),
                   opacity: Float = 1,
                   shadowRadius: CGFloat = 15) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor = .white, borderWidth: CGFloat = 1) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func addLayer(_ borderWidth: CGFloat, _ borderColor: UIColor) {
        let borderLayer = CALayer()
        let borderFrame = CGRect(x: frame.minX - 2.0, y: frame.minY - 2.0, width: frame.size.height + 2.0, height: frame.size.height + 2.0)
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = frame.width/2
        borderLayer.borderWidth = borderWidth
        borderLayer.borderColor = borderColor.cgColor
        layer.addSublayer(borderLayer)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func roundTop(radius: CGFloat = 15){
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func roundBottom(radius: CGFloat = 15){
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomRight, .bottomLeft],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func fillToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right)
        ])
    }
    
    func addBottomLine() {
        let line = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        line.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: 1).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func addBottomLine(color: UIColor) {
        let line = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        line.backgroundColor = color
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: 1).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func addHeaderBottomLine(color: UIColor, bottomAnchor: CGFloat) {
        let line = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        line.backgroundColor = color
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(
            equalTo: self.bottomAnchor, constant: bottomAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
    }
    
    func addBottomLine(color: UIColor, bottomAnchor: CGFloat) {
        let line = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        line.backgroundColor = color
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: bottomAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func addBottomLine(color: UIColor, width: CGFloat, bottomAnchor: CGFloat) {
        let line = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        line.backgroundColor = color
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: bottomAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addTopLine() {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        line.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: 0).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func addBorder(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    static func newAutoLayoutView() -> Self {
        let view = Self()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
    
    func fround(
        with cornerRadius: CGFloat,
        borderWidth: CGFloat = 0,
        color: UIColor = .clear
    ) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground(colorTop: UIColor, colorMiddle: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorMiddle.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 0.8, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

private extension UIView {
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

