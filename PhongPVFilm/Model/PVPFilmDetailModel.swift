//
//  PVPFilmDetailModel.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

struct PVPFilmDetailModel: Codable {

    var id: String = ""
    var trailer: String = ""
    var filmName: String = ""
    var description: String = ""
    var filmUrl: String = ""
    var episodes: [EpisodeInfo] = []
    var tag: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case trailer = "thumbnail"
        case filmName = "filmName"
        case description = "description"
        case tag = "tag"
    }
    
    init() { }
}

extension PVPFilmDetailModel {
    struct EpisodeInfo: Codable {
        var id: String = UUID().uuidString
        var episode: Int = 0
        var description: String = ""
        var thumbnail: String = ""
    }
}

extension PVPFilmDetailModel {
    static let mockEpisodeInfoDatas = [
        PVPFilmDetailModel.EpisodeInfo(
            episode: 1,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 2,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 3,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 4,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 5,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 6,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 7,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 8,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
        PVPFilmDetailModel.EpisodeInfo(
            episode: 9,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            thumbnail: ""),
    ]
}
