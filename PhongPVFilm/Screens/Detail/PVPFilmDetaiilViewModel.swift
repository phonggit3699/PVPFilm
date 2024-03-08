//
//  PVPFilmDetaiilViewModel.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation


class PVPFilmDetaiilViewModel {
    var film: Observable<PVPFilmDetailModel> = .init(.init())
    var action: Observable<Action?> = .init(nil)
    var navigation: Observable<Navigation?> = .init(nil)
    var mockId: String = ""
    
    private let useCase: PVPFilmDetaiilUseCase
    private let coordinator: PVPFilmDetaiilVCoordinator
    
    init(filmId: String,
         mockId: String,
         useCase: PVPFilmDetaiilUseCase,
         coordinator: PVPFilmDetaiilVCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.action.observeNext { [weak self] value in
            guard
                let self = self,
                let value = value
            else { return }
            self.setupAction(action: value)
        }
        self.film.value.id = filmId
        self.mockId = mockId
        self.action.value = .getDetailFilm
    }
    
    func setupAction(action: Action) {
        switch action {
        case .getDetailFilm:
            useCase.getDetailFilm(id: self.film.value.id, mockId: mockId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let film):
                    var newFilm = film
                    // TODO: Mock API gio han datasource
                    newFilm.episodes = PVPFilmDetailModel.mockEpisodeInfoDatas
                    self.film.value = newFilm
                case .failure(let error):
                    self.navigation.value = .showError(error)
                }
            }
        case .goToFullScreenFilmPlayer:
            coordinator.goToFullScreenFilmPlayer(urlStr: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        }
    }
}

extension PVPFilmDetaiilViewModel {
    enum Navigation {
        case showAlert(message: String)
        case showError(_ error: Error)
    }
    
    enum Action {
        case getDetailFilm
        case goToFullScreenFilmPlayer
    }
}
