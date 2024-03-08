//
//  Array+Ext.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        get {
            guard 0 <= index && index < count else { return nil }
            return self[index]
        }
        set {
            guard 0 <= index && index < count,
                  let value = newValue
            else { return }
            self[index] = value
        }
    }
}
