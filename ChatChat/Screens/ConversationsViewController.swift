//
//  ViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
//        Profile.loadCurrentProfile { profile, error in
//            guard let profile = profile else {return}
//            let firstName = profile.firstName
//            let lastName = profile.lastName
//            let email = profile.email
//
//            print(firstName)
//            print(lastName)
//            print(email)
        
        let user = Auth.auth().currentUser
        print(user)
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let name = user.displayName
          let email = user.email
            let photoURL = user.photoURL?.absoluteString
         print(uid)
         print(email)
         print(photoURL)
         print(name)
          // ...
        
        }
        
    }


}

