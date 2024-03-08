//
//  PVPFilmDetaiilUseCase.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

protocol PVPFilmDetaiilUseCase {
    func getDetailFilm(id: String,
                       mockId: String,
                       completion: ((Swift.Result<PVPFilmDetailModel, Error>) -> Void)?)
}

class PVPFilmDetaiilUseCaseDefault: PVPFilmDetaiilUseCase {
    func getDetailFilm(id: String,
                       mockId: String,
                       completion: ((Swift.Result<PVPFilmDetailModel, Error>) -> Void)?) {
        PVPFilmDetaiilAPIRouter.getDetailFilm(id: id, mockId: mockId).request { result in
            switch result {
            case .success(let data):
                do {
                    let film = try PVPFilmAPIRouterHelper.decodingToObject(data, PVPFilmDetailModel.self, isDebug: true)
                    completion?(.success(film))
                } catch {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
