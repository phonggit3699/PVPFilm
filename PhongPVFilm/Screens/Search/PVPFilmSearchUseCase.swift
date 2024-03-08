//
//  PVPFilmSearchUseCase.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

protocol PVPFilmSearchUseCase {
    func searchFilms(keyword: String,
                     completion: ((Swift.Result<[PVPFilmByCategoryModel.FilmInfo], Error>) -> Void)?)
}

class PVPFilmSearchUseCaseDefault: PVPFilmSearchUseCase {
    func searchFilms(keyword: String,
                     completion: ((Swift.Result<[PVPFilmByCategoryModel.FilmInfo], Error>) -> Void)?) {
        PVPFilmSearchAPIRouter.searchFilms(keyword: keyword).request { result in
            switch result {
            case .success(let data):
                do {
                    let filmsByCategories = try PVPFilmAPIRouterHelper.decodingToListObject(data, PVPFilmByCategoryModel.FilmInfo.self)
                    completion?(.success(filmsByCategories))
                } catch {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
