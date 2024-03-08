//
//  PVPFilmHomeViewModel.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

class PVPFilmHomeViewModel {
    
    var filmsByCategories: Observable<[PVPFilmByCategoryModel]> = .init([])
    var selectedFilmFilterType: Observable<PVPFilmFilterType> = .init(.film)
    var action: Observable<Action?> = .init(nil)
    var navigation: Observable<Navigation?> = .init(nil)
    
    private let useCase: PVPFilmHomeUseCase
    private let coordinator: PVPFilmHomeCoordinator
    
    init (useCase: PVPFilmHomeUseCase, coordinator: PVPFilmHomeCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.action.observeNext { [weak self] value in
            guard
                let self = self,
                let value = value
            else { return }
            self.setupAction(action: value)
        }
        self.action.value = .getFilmsByCategories
    }
    
    func setupAction(action: Action) {
        switch action {
        case .getFilmsByCategories:
            useCase.getFilmsByCategories { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let films):
                    self.filmsByCategories.value = films
                case .failure(let error):
                    self.navigation.value = .showError(error)
                }
            }
            
        case .goToFilmDetail(let id, let mockId):
            coordinator.goToFilmDetail(id: id, mockId: mockId)
            
        case .filterFilmsByCategories(let filterType):
            selectedFilmFilterType.value = filterType
            useCase.filterFilmsByCategories(filterType: filterType) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let films):
                    self.filmsByCategories.value = films
                case .failure(let error):
                    self.navigation.value = .showError(error)
                }
            }
        }
    }
}

extension PVPFilmHomeViewModel {
    enum Navigation {
        case showAlert(message: String)
        case showError(_ error: Error)
    }
    
    enum Action {
        case getFilmsByCategories
        case goToFilmDetail(id: String, mockId: String)
        case filterFilmsByCategories(filterType: PVPFilmFilterType)
    }
}
