//
//  ProfileInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit
import FBSDKLoginKit


class ProfileInteractor:PresenterToInteractorProfileProcotol {
    var navigationController: UINavigationController?
    
    func logOut() {
        
        let actionSheet = UIAlertController(title: "Do you want to logout?", message: "", preferredStyle: .actionSheet)
        
        actionSheet.configureAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.configureAction(title: "Logout", style: .default) { [weak self] _ in
            AuthManager.shared.firebaseLogOut { bool in
                if bool {
                    LoginManager().logOut()
                    let navLoginVc = UINavigationController(rootViewController: LoginViewController())
                    navLoginVc.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(navLoginVc, animated: true)
                    
                    
                }
            }
        }
        navigationController?.present(actionSheet, animated: true)
        
        
    }
    
    
}
