//
//  TabbarController.swift
//  FoodOrderApp
//
//  Created by Aynur on 09.01.26.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setupController() {
        let home = storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
        home.tabBarItem.image = UIImage(systemName: "material-symbols_home-rounded")
        
        let basket = storyboard?.instantiateViewController(withIdentifier: "BasketController") as! BasketController
        basket.tabBarItem.image = UIImage(systemName: "material-symbols_add-shopping-cart")
        
        viewControllers = [home,basket]
        
    }
 

}
