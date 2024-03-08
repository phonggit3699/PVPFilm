//
//  PVPFilmError.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

enum PVPFilmError: LocalizedError {
    static let genericError = "Có lỗi xảy ra"
    
    case localError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .localError(let message):
            return message
        }
    }
}
