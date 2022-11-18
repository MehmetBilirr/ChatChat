//
//  LoginProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterRegisterProtocol{
    var registerInteractor : PresenterToInteractorRegisterProtocol? {get set}
    func register(profileImageView:UIImageView,firstName:String,lastName:String,email:String,password:String)


}

protocol PresenterToInteractorRegisterProtocol{
    var navigationController:UINavigationController? {get set}
    func register(profileImageView:UIImageView,firstName:String,lastName:String,email:String,password:String)
}




protocol PresenterToRouterRegisterProtocol {
    static func createModule(ref : RegisterViewController,navigationController:UINavigationController)
}

