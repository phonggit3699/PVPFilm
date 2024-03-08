//
//  AppDelegate.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit
import AVKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().barTintColor = UIColor(named: "pvpf_color_bg")
        UINavigationBar.appearance().barTintColor = UIColor(named: "pvpf_color_bg")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "pvpf_color_bg")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let navVC = UINavigationController(rootViewController: PVPFilmTabBarViewController())
        navVC.isNavigationBarHidden = true
        navVC.isToolbarHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .black
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // MARK: Auto landscapeRight khi xem vao man xem fullscreen
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            if navigationController.visibleViewController is AVPlayerViewController {
                return UIInterfaceOrientationMask.landscapeRight
            } else {
                return UIInterfaceOrientationMask.portrait
            }
        }
        return UIInterfaceOrientationMask.all
    }
}

