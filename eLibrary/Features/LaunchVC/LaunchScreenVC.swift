//
//  LaunchVC.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit
import Lottie

class LaunchScreenVC: UIViewController, Coordinator {
    
    private var animationView = LottieAnimationView.newAutoLayoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        animationView.backgroundColor = .white
        animationView.fillToSuperview()
        

        animationView.animation = LottieAnimation.named("booksAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) {
            self.navigate(NavigationItem(page: .main, navigationStyle: .push(animated: true)))
        }

    }
}
