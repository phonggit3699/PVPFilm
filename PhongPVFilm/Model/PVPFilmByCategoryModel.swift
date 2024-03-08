//
//  PVPFilmByCategoryModel.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

struct PVPFilmByCategoryModel: Codable {
    var id: String = ""
    var titleCategory: String = ""
    var films: [FilmInfo] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case titleCategory = "titleCategory"
        case films = "films"
    }
}

extension PVPFilmByCategoryModel {
    struct FilmInfo: Codable {
        var id: String = ""
        var thumbnail: String = ""
        var filmName: String = ""
        var tag: Int = 0
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case thumbnail = "thumbnail"
            case filmName = "filmName"
            case tag = "tag"
        }
    }
    
    enum TagType: Int, Codable {
        case unowned
        case recentlyAdded = 1
        
        var title: String {
            switch self {
            case .unowned:
                return ""
            case .recentlyAdded:
                return "Recently Added"
            }
        }
    }
}

extension PVPFilmByCategoryModel {
    static let mockData = [
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        ),
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        ),
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        ),
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        ),
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        ),
        PVPFilmByCategoryModel(
            id: UUID().uuidString,
            titleCategory: "Hello",
            films: PVPFilmByCategoryModel.FilmInfo.mockData
        )
    ]
    
    
}

extension PVPFilmByCategoryModel.FilmInfo {
    static let mockData = [
        PVPFilmByCategoryModel.FilmInfo(
            id: UUID().uuidString,
            thumbnail: "https://cache.giaohangtietkiem.vn/d/3535a7c6c246cda7c450daf6e705e911.jpg?width=450&height=257",
            filmName: "Đây là tên phim"
        ),
        PVPFilmByCategoryModel.FilmInfo(
            id: UUID().uuidString,
            thumbnail: "https://cache.giaohangtietkiem.vn/d/3535a7c6c246cda7c450daf6e705e911.jpg?width=450&height=257",
            filmName: "Đây là tên phim"
        ),
        PVPFilmByCategoryModel.FilmInfo(
            id: UUID().uuidString,
            thumbnail: "https://cache.giaohangtietkiem.vn/d/3535a7c6c246cda7c450daf6e705e911.jpg?width=450&height=257",
            filmName: "Đây là tên phim"
        ),
        PVPFilmByCategoryModel.FilmInfo(
            id: UUID().uuidString,
            thumbnail: "https://cache.giaohangtietkiem.vn/d/3535a7c6c246cda7c450daf6e705e911.jpg?width=450&height=257",
            filmName: "Đây là tên phim"
        ),
        PVPFilmByCategoryModel.FilmInfo(
            id: UUID().uuidString,
            thumbnail: "https://cache.giaohangtietkiem.vn/d/3535a7c6c246cda7c450daf6e705e911.jpg?width=450&height=257",
            filmName: "Đây là tên phim"
        )
    ]
}
