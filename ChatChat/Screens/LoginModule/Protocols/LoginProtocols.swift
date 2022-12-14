//
//  LoginProtocol.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterLoginProtocol{
    var loginInteractor : PresenterToInteractorLoginProtocol? {get set}
    
    func login(email:String,password:String)
    func loginWithFB(token:String)
    func loginWithGoogle(viewController:UIViewController)
    func register()

}

protocol PresenterToInteractorLoginProtocol{
    var navigationController:UINavigationController? {get set}
    func login(email:String,password:String)
    func loginWithFB(token:String)
    func loginWithGoogle(viewController:UIViewController)
    func register()
}




protocol PresenterToRouterLoginProtocol {
    static func createModule(ref : LoginViewController,navigationController:UINavigationController)
}
