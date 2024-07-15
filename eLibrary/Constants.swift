//
//  Constants.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

class Constants {
    static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    static let screenSize = UIScreen.main.bounds.size
    static let appDelegate = UIApplication.shared.delegate as? SceneDelegate
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    static let osVersion = UIDevice.current.systemVersion
    static let appPlatform = "ios"
    static let deviceManufacturer = "Apple Inc."
    static let strCssHead = """
            <head>\
            <link rel="stylesheet" type="text/css" href="about.css">\
            </head>
            """
    static let metaTag = """
            <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
            """
    
    static func getTopSafeArea() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if let top = window?.safeAreaInsets.top {
            return top
        }
        return 0
    }
    
    static func getBottomSafeArea() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if let bottom = window?.safeAreaInsets.top {
            return bottom
        }
        return 0
    }
}
