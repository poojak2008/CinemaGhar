//
//  ViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 09/12/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .secondarySystemBackground
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
       
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "flame")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        
        
        
        vc1.title = "Home"
        vc2.title = "Trending"
        vc3.title = "Top Search"
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }


}

