//
//  ViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import FBSDKLoginKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        Profile.loadCurrentProfile { profile, error in
            guard let profile = profile else {return}
            let firstName = profile.firstName
            let lastName = profile.lastName
            let email = profile.email
            
            print(firstName)
            print(lastName)
            print(email)
           
        }
        
    }


}

