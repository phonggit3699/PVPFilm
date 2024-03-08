//
//  PVPFilmHomeAPIRouter.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

enum PVPFilmHomeAPIRouter: PVPFilmBaseAPIRouter {
    
    case getFilmsByCategories
    case filterFilmsByCategories(filterBy: String)
    
    func baseUrl() -> String {
        "https://65e931294bb72f0a9c50e54c.mockapi.io"
    }
    
    func path() -> String {
        switch self {
        case .getFilmsByCategories,
                .filterFilmsByCategories:
            return "/filmByCategory"
        }
    }
    
    func method() -> HTTPMethod {
        .GET
    }
    
    func parameters() -> [String : Any] {
        var params: [String : Any] = [:]
        switch self {
        case .getFilmsByCategories:
            break
        case .filterFilmsByCategories(let filterBy):
            params["filterBy"] = filterBy
        }
        return params
    }
}
