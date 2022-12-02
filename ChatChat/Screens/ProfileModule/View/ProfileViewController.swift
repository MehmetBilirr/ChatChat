//
//  ProfileViewControllerViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    var picker = false
    var presenter:ViewToPresenterProfileProtocol?
    private let userNameLbl = UILabel()
    private let userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    private let settingsLbl = UILabel()
    private let betweenView1 = UIView()
    private let statusLbl = UILabel()
    private let statusTxtFld = UITextField()
    private let statusPickerView = UIPickerView()
    private let betweenView2 = UIView()
    private let changePasswordLbl = UILabel()
    private let newPasswordTxtFld = UITextField()
    private let changeButton = UIButton()
    private let betweenView3 = UIView()
    private let deleteButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileRouter.createModule(ref: self, navigationController: navigationController!)
        presenter?.viewDidLoad()
    }
  
    @objc func didLogOutButton(_ sender:UIBarButtonItem){
        presenter?.logOut()
    }
    
    @objc func didTap() {
        picker = false
        view.endEditing(true)
    }
    
    @objc func didTapChangePassword(){
        guard let pass = newPasswordTxtFld.text else {return}
        presenter?.didTapChangePassword(newPass:pass )
        newPasswordTxtFld.text = ""
    }
    
    @objc func didTapDelete(){
        let actionSheet = UIAlertController(title: "Are you sure", message:"", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: {  _ in
            self.presenter?.didTapDelete()
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Cancel.rawValue, style: .cancel))
        
        present(actionSheet, animated: true)
        
    }
}


extension ProfileViewController:PresenterToViewProfileProtocol {
    var isActive: Bool {
        return picker
    }
    func style(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .systemBackground
        
        userImageView.configureImageView()
        userImageView.image = UIImage(named: "person")
        
        userNameLbl.configureStyle(size: 20, weight: .medium, color: .black)
        userNameLbl.text = "Mehmet Bilir"
        
        settingsLbl.configureStyle(size: 20, weight: .medium, color: .systemRed)
        settingsLbl.text = "Settings"
        
        betweenView1.configureBetweenView()
        
        betweenView2.configureBetweenView()
        
        betweenView3.configureBetweenView()
        
        statusLbl.configureStyle(size: 15, weight: .medium, color: .black)
        statusLbl.text = "Status"
        
        changePasswordLbl.configureStyle(size: 15, weight: .medium, color: .black)
        changePasswordLbl.text = "Change Password"
        
        newPasswordTxtFld.configureStyle(placeHolder: "New Password", txtColor: .black)
        newPasswordTxtFld.isSecureTextEntry = true
 
        
        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(.link, for: .normal)
        changeButton.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
        
        deleteButton.setTitle("Delete Account", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }
    
    func layout(){
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(150)
        }
        
        view.addSubview(userNameLbl)
        
        userNameLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImageView.snp.bottom).offset(10)
        }
        
        view.addSubview(settingsLbl)
        
        settingsLbl.snp.makeConstraints { make in
            make.right.equalTo(userNameLbl.snp.left)
            make.top.equalTo(userNameLbl.snp.bottom).offset(20)
        }
        
        view.addSubview(betweenView1)
        betweenView1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.top.equalTo(settingsLbl.snp.bottom).offset(20)
            
        }
        
        view.addSubview(statusLbl)
        
        statusLbl.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.top.equalTo(betweenView1.snp.bottom).offset(10)
        }
        
        view.addSubview(statusTxtFld)
        statusTxtFld.snp.makeConstraints { make in
            make.right.equalTo(betweenView1.snp.right)
            make.top.equalTo(betweenView1.snp.bottom).offset(10)
        }
        
        view.addSubview(betweenView2)
        
        betweenView2.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.right.equalTo(betweenView1.snp.right)
            make.top.equalTo(statusLbl.snp.bottom).offset(10)
        }
        
        view.addSubview(changePasswordLbl)
        
        changePasswordLbl.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.top.equalTo(betweenView2.snp.bottom).offset(10)
        }
        
        view.addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.right.equalTo(betweenView1.snp.right)
            make.top.equalTo(changePasswordLbl.snp.bottom).offset(5)
        }
        
        view.addSubview(newPasswordTxtFld)
        newPasswordTxtFld.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.top.equalTo(changePasswordLbl.snp.bottom).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(betweenView3)
        betweenView3.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.right.equalTo(betweenView1.snp.right)
            make.top.equalTo(changeButton.snp.bottom).offset(10)
        }
        
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(betweenView1.snp.left)
            make.top.equalTo(betweenView3.snp.bottom).offset(10)
        }
    }
    
    func configureNavigation() {
        title = "Profile"
        let logOutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logOutImage, style: .plain, target: self, action: #selector(didLogOutButton(_:)))
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configurePickerView() {
        
        statusPickerView.delegate = self
        statusPickerView.dataSource = self
        statusTxtFld.inputView = statusPickerView
        statusTxtFld.textAlignment = .center
        statusTxtFld.placeholder = "Online"
    }
    
}

extension ProfileViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.numberOfRowsPicker() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.titlePicker(for: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker = true
        statusTxtFld.placeholder = presenter?.titlePicker(for: row)
        presenter?.didselectRow(for: row)
    }
    
    
}
    
    

