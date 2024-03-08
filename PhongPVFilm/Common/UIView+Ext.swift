//
//  UIView+Ext.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

public
extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

public extension UIView {
    @IBInspectable var makeCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map({ UIColor(cgColor: $0) })
        }
        set {
            if #available(iOS 13, *) {
                layer.borderColor = newValue?.resolvedColor(with: traitCollection).cgColor
            } else {
                layer.borderColor = newValue?.cgColor
            }
        }
    }
    
    @discardableResult
    func loadViewFromNib (bundle: Bundle?) -> UIView? {
        let nib = UINib(nibName: self.className,
                        bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else { return nil }
        
        self.addSubview(nibView)
        let constraints = [
            NSLayoutConstraint(item: nibView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nibView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nibView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            
        ]
        self.addConstraints(constraints)
        self.sendSubviewToBack(nibView)
        
        return nibView
    }
}
