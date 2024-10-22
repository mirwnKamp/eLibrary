//
//  AlertVC+Main.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

import UIKit

extension AlertVC {
    enum AlertType {
        case genericError(title: String?, description: String?, actionAfterHide: ()->())
        case emailFormatError(title: String?, description: String?, actionAfterHide: ()->())
        case credsError(title: String?, description: String?, actionAfterHide: ()->(), action: ()->())
    }
}
