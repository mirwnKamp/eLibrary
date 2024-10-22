//
//  AlertPresentableVC.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

import UIKit

protocol AlertPresentableVC where Self: UIViewController {
    @discardableResult func presentAlert(_ alertType: AlertVC.AlertType) -> AlertVC
}
