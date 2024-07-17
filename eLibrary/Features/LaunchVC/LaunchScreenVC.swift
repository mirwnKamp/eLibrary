//
//  LaunchVC.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

class LaunchScreenVC: UIViewController, Coordinator {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigate(NavigationItem(page: .main, navigationStyle: .push(animated: false)))
    }
}
