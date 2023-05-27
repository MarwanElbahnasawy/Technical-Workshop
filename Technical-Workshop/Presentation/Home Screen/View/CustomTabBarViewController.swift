//
//  CustomTabBarViewController.swift
//  Technical-Workshop
//
//  Created by moamen ali gomaa on 26/05/2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
        let color = UIColor(named: "LikeButtonColor")
      
        }
    
    func createTabBarController() {
        
        //MARK: initialize home view controller
        
        let homeViewController = UIStoryboard(name: "HomeScreenStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenStoryboard")
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "homekit"), tag: 0)
 
        //MARK: initialize home view controller
        
        let favoriteViewController =  UIStoryboard(name: "FavoritesScreenStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FavoritesScreenStoryboard")
        favoriteViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 1)
    
        let controllerArray = [homeViewController, favoriteViewController]
         self.viewControllers = controllerArray
    }

    }

