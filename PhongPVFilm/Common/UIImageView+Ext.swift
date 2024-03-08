//
//  UIImageView+Ext.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import UIKit


extension UIImageView {
    func downloadImageFromUrl(url: String, placeHolderImage: UIImage? = UIImage(named: "pvpf_img_bg")) {
        guard let url = URL(string: url) else {
            self.image = placeHolderImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                self?.image = placeHolderImage
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
