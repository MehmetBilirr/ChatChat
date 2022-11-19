//
//  ProfileInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


class ProfileInteractor:PresenterToInteractorProfileProcotol {
    var navigationController: UINavigationController?
    
    func logOut() {
        AuthManager.shared.firebaseLogOut { bool in
            if bool {
                let navLoginVc = UINavigationController(rootViewController: LoginViewController())
                navLoginVc.modalPresentationStyle = .fullScreen
                navigationController?.present(navLoginVc, animated: true)
                
                
            }
        }
    }
    
    
}
