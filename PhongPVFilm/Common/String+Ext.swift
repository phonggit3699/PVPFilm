//
//  String+Ext.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

public
extension String {
    
    func width(consideringHeight height: CGFloat, font: UIFont) -> CGFloat {
        let size = self.size(consideringHeight: height, font: font)
        return size.width
    }
    
    func size(consideringHeight height: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        return self.size(consideringRect: constraintRect, font: font)
    }
    
    func size(consideringRect size: CGSize, font: UIFont) -> CGSize {
        let rect = self.boundingRect(with: size,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil).integral
        return rect.size
    }
}
