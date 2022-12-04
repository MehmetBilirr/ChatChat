//
//  PrfileProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterProfileProtocol {
    var interactor:PresenterToInteractorProfileProcotol?{get set}
    var view:PresenterToViewProfileProtocol?{get set}
    func viewDidLoad()
    func  logOut()
    func numberOfRowsPicker()->Int
    func titlePicker(for row:Int)->String
    func didselectRow(for row:Int)
    func didTapChangePassword(newPass:String)
    func didTapDelete()
    func getUser()
}

protocol PresenterToInteractorProfileProcotol {
    var presenter:InteractorToPresenterProfileProtocol?{get set}
    var navigationController:UINavigationController? {get set}
    func updateStatus(status:Status)
    func didTapChangePassword(newPass:String)
    func didTapDelete()
    func  logOut()
    func getUser()
}

protocol PresenterToViewProfileProtocol {
    var isActive:Bool{get}
    var presenter:ViewToPresenterProfileProtocol?{get set}
    func style()
    func layout()
    func configureNavigation()
    func configurePickerView()
    func getUser()
    func didFetchUser(user:User)
    
}

protocol InteractorToPresenterProfileProtocol {
    func didFetchUser(user:User)
}


protocol PresenterToRouterProfileProtocol {
    static func createModule(ref : ProfileViewController,navigationController:UINavigationController)
}
