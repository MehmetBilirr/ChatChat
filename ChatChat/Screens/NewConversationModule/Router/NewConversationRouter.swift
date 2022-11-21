//
//  NewConversationRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

class NewConversationRouter:PresenterToRouterNewConversationProtocol {
    static func createModule(ref: NewConversationViewController, navigationController: UINavigationController) {
        let presenter = NewConversationPresenter()
        let interactor = NewConversationInteractor()
        ref.newConversationPresenter = presenter
        ref.newConversationPresenter?.newConversationView = ref
        ref.newConversationPresenter?.newConversationInteractor = interactor
        ref.newConversationPresenter?.newConversationInteractor?.newConversationPresenter = presenter
        ref.newConversationPresenter?.newConversationInteractor?.navigationController = navigationController
        
    }
    
    
}
