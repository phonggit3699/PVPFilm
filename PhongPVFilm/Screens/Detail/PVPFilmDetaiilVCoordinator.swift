//
//  PVPFilmDetaiilVCoordinator.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import UIKit
import AVKit


protocol PVPFilmDetaiilVCoordinator {
    func goToFullScreenFilmPlayer(urlStr: String)
}

class PVPFilmDetaiilVCoordinatorDefault: PVPFilmDetaiilVCoordinator {
    weak var navigationController: UINavigationController?
    
    func goToFullScreenFilmPlayer(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        player.play()
        navigationController?.present(playerViewController, animated: true)
    }
}
