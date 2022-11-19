//
//  PrfileProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterProfileProtocol {
    var profileInteractor:PresenterToInteractorProfileProcotol?{get set}
    func  logOut()
}

protocol PresenterToInteractorProfileProcotol {
    var navigationController:UINavigationController? {get set}
    func  logOut()
}

protocol PresenterToRouterProfileProtocol {
    static func createModule(ref : ProfileViewController,navigationController:UINavigationController)
}
