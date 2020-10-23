//
//  ViewControllerExtension.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit

extension UIViewController {
    func showError(
        title: String,
        message: String,
        actionTitle: String = "OK",
        handler: (() -> Void)? = nil
    ) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) { _ in

            handler?()
        })

        present(alert, animated: true, completion: nil)
    }
}
