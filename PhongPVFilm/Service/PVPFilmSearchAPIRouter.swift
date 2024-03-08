//
//  PVPFilmSearchAPIRouter.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

enum PVPFilmSearchAPIRouter: PVPFilmBaseAPIRouter {
    
    case searchFilms(keyword: String)
    
    func baseUrl() -> String {
        "https://65e931294bb72f0a9c50e54c.mockapi.io"
    }
    
    func path() -> String {
        switch self {
        case .searchFilms:
            return "/filmByCategory/1/films"
        }
    }
    
    func method() -> HTTPMethod {
        .GET
    }
    
    func parameters() -> [String : Any] {
        var params: [String : Any] = [:]
        switch self {
        case .searchFilms(let keyword):
            if !keyword.isEmpty {
                params["filmName"] = keyword
            }
        }
        return params
    }
}
