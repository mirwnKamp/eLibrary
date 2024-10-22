//
//  AlertPresentableVC+Main.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 22/10/24.
//

extension AlertPresentableVC {
    @discardableResult func presentAlert(_ alertType: AlertVC.AlertType) -> AlertVC {
        var alert: AlertVC!

        switch alertType {
        case .genericError(let t, let d, let a): alert = genericError(title: t, description: d, actionAfterHide: a)
        case .emailFormatError(let t, let d, actionAfterHide: let a): alert = emailFormatError(title: t, description: d, actionAfterHide: a)
        case .credsError(let t, let d, let a, let b): alert = credsError(title: t, description: d, actionAfterHide: a, singUpAction: b)
        }

        alert.modalPresentationStyle = .overFullScreen
        present(alert, animated: true)

        return alert
    }
}
