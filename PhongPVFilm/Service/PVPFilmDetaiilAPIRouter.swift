//
//  PVPFilmDetaiilAPIRouter.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import Foundation

enum PVPFilmDetaiilAPIRouter: PVPFilmBaseAPIRouter {
    
    case getDetailFilm(id: String, mockId: String)
    
    func baseUrl() -> String {
        "https://65e931294bb72f0a9c50e54c.mockapi.io"
    }
    
    func path() -> String {
        switch self {
        case .getDetailFilm(let id, let mockId):
            return "/filmByCategory/\(mockId)/films/\(id)"
        }
    }
    
    func method() -> HTTPMethod {
        .GET
    }
    
    func parameters() -> [String : Any] {
        var params: [String : Any] = [:]
        switch self {
        case .getDetailFilm(let id):
            break
        }
        return params
    }
}
