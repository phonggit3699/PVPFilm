//
//  PVPFilmFilterType.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import Foundation

enum PVPFilmFilterType: String, CaseIterable {
    case series
    case film
    case cartoon
    case anime
    case new
    
    var title: String {
        switch self {
        case .series:
            return "Series"
        case .film:
            return "Film"
        case .cartoon:
            return "Cartoon"
        case .anime:
            return "Anime"
        case .new:
            return "New & Popular"
        }
    }
}
