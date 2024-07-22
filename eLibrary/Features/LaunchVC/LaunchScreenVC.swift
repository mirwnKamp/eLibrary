//
//  LaunchVC.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit
import Lottie
import FirebaseAuth

class LaunchScreenVC: UIViewController, Coordinator {
    
    private var animationView = LottieAnimationView.newAutoLayoutView()
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        animationView.backgroundColor = .white
        animationView.fillToSuperview()

        animationView.animation = LottieAnimation.named("booksAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()

        
        if firebaseAuth.currentUser != nil {
            firebaseAuth.currentUser?.reload { error in
                
                if let error = error  {
                    print(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                        self?.navigate(NavigationItem(page: .login, navigationStyle: .push(animated: true)))
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                        self?.navigate(NavigationItem(page: .main, navigationStyle: .push(animated: true)))
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                self?.navigate(NavigationItem(page: .login, navigationStyle: .push(animated: true)))
            }
        }
    }
}
