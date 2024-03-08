//
//  PVPFilmSearchCoordinator.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import UIKit


protocol PVPFilmSearchCoordinator {
    func goToFilmDetail(id: String, mockId: String)
}
 
class PVPFilmSearchCoordinatorDefault: PVPFilmSearchCoordinator {
    weak var navigationController: UINavigationController?
    
    func goToFilmDetail(id: String, mockId: String) {
        let coordinator = PVPFilmDetaiilVCoordinatorDefault()
        coordinator.navigationController = navigationController
        let vc = PVPFilmDetaiilViewController.makeScreen(filmId: id, 
                                                         mockId: mockId,
                                                         coordinator: coordinator)
        navigationController?.pushViewController(vc, animated: true)
    }
}
