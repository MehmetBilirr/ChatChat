//
//  ProfilePresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation

class ProfilePresenter:ViewToPresenterProfileProtocol {
    var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProcotol?
    
    let pickerArray : [Status] = [Status.Online,Status.Busy,Status.Outside]
    
    func logOut() {
        interactor?.logOut()
    }
    
    func titlePicker(for row: Int) -> String {
        return pickerArray[row].rawValue
    }
    
    func numberOfRowsPicker() -> Int {
        return pickerArray.count
    }
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
        view?.configureNavigation()
        view?.configurePickerView()
    }
    
    func didselectRow(for row: Int) {
        interactor?.updateStatus(status: pickerArray[row])
    }
    
    func didTapChangePassword(newPass: String) {
        interactor?.didTapChangePassword(newPass: newPass)
    }
    
    func didTapDelete() {
        interactor?.didTapDelete()
    }
}
