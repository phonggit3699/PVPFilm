//
//  PVPFilmSearchViewModel.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

class PVPFilmSearchViewModel {
    var films: Observable<[PVPFilmByCategoryModel.FilmInfo]> = .init([])
    var action: Observable<Action?> = .init(nil)
    var navigation: Observable<Navigation?> = .init(nil)
    
    private let useCase: PVPFilmSearchUseCase
    private let coordinator: PVPFilmSearchCoordinator
    
    init(useCase: PVPFilmSearchUseCase, coordinator: PVPFilmSearchCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.action.observeNext { [weak self] value in
            guard
                let self = self,
                let value = value
            else { return }
            self.setupAction(action: value)
        }
        self.action.value = .initSearchFilms
    }
    
    func setupAction(action: Action) {
        switch action {
        case .typingSearchBar(let keyword):
            useCase.searchFilms(keyword: keyword) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let films):
                    self.films.value = films
                case .failure(let error):
                    self.navigation.value = .showError(error)
                }
            }
            
        case .initSearchFilms:
            useCase.searchFilms(keyword: "") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let films):
                    self.films.value = films
                case .failure(let error):
                    self.navigation.value = .showError(error)
                }
            }
            
        case .goToFilmDetail( let index):
            guard let filmId = films.value[safeIndex: index]?.id else {
                return
            }
            coordinator.goToFilmDetail(id: filmId, mockId: "1")
        }
    }
}

extension PVPFilmSearchViewModel {
    enum Navigation {
        case showAlert(message: String)
        case showError(_ error: Error)
    }
    
    enum Action {
        case initSearchFilms
        case typingSearchBar(keyword: String)
        case goToFilmDetail(index: Int)
    }
}
