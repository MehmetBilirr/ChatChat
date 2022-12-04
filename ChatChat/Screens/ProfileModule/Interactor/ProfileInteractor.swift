//
//  ProfileInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FirebaseAuth


class ProfileInteractor:PresenterToInteractorProfileProcotol {
    var navigationController: UINavigationController?
    var presenter: InteractorToPresenterProfileProtocol?
    func logOut() {
        
        let actionSheet = UIAlertController(title: "Do you want to logout?", message: "", preferredStyle: .actionSheet)
        
        actionSheet.configureAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.configureAction(title: "Logout", style: .default) { _ in
            AuthManager.shared.firebaseLogOut { bool in
                if bool {

                    LoginManager().logOut()
                    self.pushToLoginVC()
                    
                    
                }
            }
        }
        navigationController?.present(actionSheet, animated: true)
        
        
    }
    
    func updateStatus(status: Status) {
        DataBaseManager.shared.updateStatus(status: status)
    }
    
    func didTapChangePassword(newPass: String) {
        AuthManager.shared.changePassword(newPass: newPass)
    }
    
    func didTapDelete() {
        AuthManager.shared.deleteAccount { bool in
            if bool {
                self.pushToLoginVC()
            }
        }
    }
    
    private func pushToLoginVC(){
        let navLoginVc = UINavigationController(rootViewController: LoginViewController())
        navLoginVc.modalPresentationStyle = .fullScreen
        navigationController?.present(navLoginVc, animated: true)
    }
    func getUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        DataBaseManager.shared.fetchUserAddSnapshotListener(uuid: uid) { [weak self] user in
            self?.presenter?.didFetchUser(user: user)
        }
    }
    
}


