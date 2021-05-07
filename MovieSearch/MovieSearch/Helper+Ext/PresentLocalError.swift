//
//  PresentLocalError.swift
//  MovieSearch
//
//  Created by Myles Cashwell on 5/7/21.
//

import UIKit

extension UITableViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
