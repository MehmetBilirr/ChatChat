//
//  ProfilePresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation

class ProfilePresenter:ViewToPresenterProfileProtocol {
    var profileInteractor: PresenterToInteractorProfileProcotol?
    
    func logOut() {
        profileInteractor?.logOut()
    }
    
    
}
