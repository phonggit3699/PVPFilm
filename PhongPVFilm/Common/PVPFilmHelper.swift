//
//  PVPFilmHelper.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import UIKit


class PVPFilmHelper {
    static func showAlert(title: String = "Thông báo",
                          message: String,
                          fromVC: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        fromVC.present(alert, animated: true)
    }
    
    static func showAlert(title: String = "Thông báo",
                          error: Error,
                          fromVC: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        fromVC.present(alert, animated: true)
    }
}
