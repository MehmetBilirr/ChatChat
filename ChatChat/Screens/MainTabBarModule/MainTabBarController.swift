//
//  MainTabBarController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setup()
    }
    private func setup(){
        
        let nc1 = UINavigationController(rootViewController: ConversationsViewController())
        let nc2 = UINavigationController(rootViewController: ProfileViewController())

        
        nc1.tabBarItem.image = UIImage(systemName: "ellipsis.bubble")
        nc1.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.bubble.fill")
        
        nc2.tabBarItem.image = UIImage(systemName: "person")
        nc2.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        
        setViewControllers([nc1,nc2], animated: true)
    }

}
