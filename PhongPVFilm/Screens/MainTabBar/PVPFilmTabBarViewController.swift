//
//  PVPFilmTabBarViewController.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

class PVPFilmTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeVC = createHomeController()
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(named: "pvpf_ic_home"),
                                          selectedImage: nil)
        
        let searchVC = createSearchController()
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                        image: UIImage(named: "pvpf_ic_magnifyingglass"),
                                        selectedImage: nil)
        
        viewControllers = [homeVC, searchVC]
    }
    
    
    private func createHomeController() -> UIViewController {
        let coordinator = PVPFilmHomeCoordinatorDefault()
        let homeViewController = PVPFilmHomeViewController.makeScreen(coordinator: coordinator)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        coordinator.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func createSearchController() -> UIViewController {
        let coordinator = PVPFilmSearchCoordinatorDefault()
        let searchViewController = PVPFilmSearchViewController.makeScreen(coordinator: coordinator)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        coordinator.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
