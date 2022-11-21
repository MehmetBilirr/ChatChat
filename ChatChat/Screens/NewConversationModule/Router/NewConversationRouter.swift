//
//  NewConversationRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

class NewConversationRouter:PresenterToRouterNewConversationProtocol {
    static func createModule(ref: NewConversationViewController, navigationController: UINavigationController?) {
        let presenter = NewConversationPresenter()
        let interactor = NewConversationInteractor()
        ref.presenter = presenter
        ref.presenter?.view = ref
        ref.presenter?.interactor = interactor
        ref.presenter?.interactor?.presenter = presenter
        ref.presenter?.interactor?.navigationController = navigationController
        
    }
    
    
}
