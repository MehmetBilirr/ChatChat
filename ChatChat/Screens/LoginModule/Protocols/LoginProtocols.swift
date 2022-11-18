//
//  LoginProtocol.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterLoginProtocol:AnyObject{
    var loginInteractor : PresenterToInteractorLoginProtocol? {get set}
    
    func login(email:String,password:String)
    func register()

}

protocol PresenterToInteractorLoginProtocol:AnyObject{
    var navigationController:UINavigationController? {get set}
    func login(email:String,password:String)
    func register()
}




protocol PresenterToRouterLoginProtocol:AnyObject {
    static func createModule(ref : LoginViewController,navigationController:UINavigationController)
}
