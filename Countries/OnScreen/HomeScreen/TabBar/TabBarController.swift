//
//  TabBarController.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .systemRed
        
        prepareUI()
        makeHomeViewReady()
    }
    
    private func prepareUI() {
        tabBar.backgroundColor = .systemBackground
    }
    
    private func makeHomeViewReady() {
        var viewControllers = [UIViewController]()
        
        let homeViewController = UINavigationController(rootViewController: HomeView())
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        viewControllers.append(homeViewController)
        
        let savedViewController = UINavigationController(rootViewController: SavedCountriesViewController())
        savedViewController.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName:"heart"), selectedImage: UIImage(systemName: "heart.fill"))
        viewControllers.append(savedViewController)
        
        self.viewControllers = viewControllers
    }
    
}
