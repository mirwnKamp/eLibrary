//
//  AlertPresentableVC+Generic.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

import UIKit

extension AlertPresentableVC {
    func genericError(title: String?, description: String?, actionAfterHide: @escaping ()->()) -> AlertVC {
        AlertVC(
            alertTitle: title ?? "Oops!",
            subtitle: description ?? "Unknown Error",
            mainButton: AlertButton(title: "OK", actionAfterHide: actionAfterHide)
        )
    }
    
    func emailFormatError(title: String?, description: String?, actionAfterHide: @escaping ()->()) -> AlertVC {
        AlertVC(
            alertTitle: title ?? "Oops!",
            subtitle: description ?? "Unknown Error",
            mainButton: AlertButton(title: "OK", actionAfterHide: actionAfterHide)
        )
    }
    
    func credsError(title: String?, description: String?, actionAfterHide: @escaping ()->(), singUpAction: @escaping ()->()) -> AlertVC {
        AlertVC(
            alertTitle: title ?? "Oops!",
            subtitle: description ?? "Unknown Error",
            mainButton: AlertButton(title: "OK", actionAfterHide: actionAfterHide),
            secondaryButton: AlertButton(title: "Sign Up", actionAfterHide: singUpAction)
        )
    }

}

