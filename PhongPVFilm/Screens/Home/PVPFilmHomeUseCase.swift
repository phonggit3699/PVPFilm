//
//  PVPFilmHomeUseCase.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

protocol PVPFilmHomeUseCase {
    func getFilmsByCategories(completion: ((Swift.Result<[PVPFilmByCategoryModel], Error>) -> Void)?)
    
    func filterFilmsByCategories(filterType: PVPFilmFilterType, completion: ((Swift.Result<[PVPFilmByCategoryModel], Error>) -> Void)?)
}

class PVPFilmHomeUseCaseDefault: PVPFilmHomeUseCase {
    func getFilmsByCategories(completion: ((Swift.Result<[PVPFilmByCategoryModel], Error>) -> Void)?) {
        PVPFilmHomeAPIRouter.getFilmsByCategories.request { result in
            switch result {
            case .success(let data):
                do {
                    let filmsByCategories = try PVPFilmAPIRouterHelper.decodingToListObject(data, PVPFilmByCategoryModel.self)
                    completion?(.success(filmsByCategories))
                } catch {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func filterFilmsByCategories(filterType: PVPFilmFilterType,
                                 completion: ((Swift.Result<[PVPFilmByCategoryModel], Error>) -> Void)?) {
        PVPFilmHomeAPIRouter.filterFilmsByCategories(filterBy: filterType.rawValue).request { result in
            switch result {
            case .success(let data):
                do {
                    let filmsByCategories = try PVPFilmAPIRouterHelper.decodingToListObject(data, PVPFilmByCategoryModel.self)
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
