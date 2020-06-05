//
//  Extension+String.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let newDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "E, d MMM yyyy"
        let newDateString = dateFormatter.string(from: newDate ?? Date())
        return newDateString
    }
}

extension UIViewController {
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
