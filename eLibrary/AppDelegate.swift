//
//  AppDelegate.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 12/7/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    @objc func authenticationFailed() {
        // Post a notification to inform SceneDelegate about authentication failure
        NotificationCenter.default.post(name: NSNotification.Name("AuthenticationFailed"), object: nil)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL,
              URLComponents(url: url, resolvingAgainstBaseURL: true) != nil else {
            return false
        }
        // Post a notification to inform SceneDelegate about the URL
        NotificationCenter.default.post(name: NSNotification.Name("ContinueUserActivity"), object: url)
        return true
    }
}
