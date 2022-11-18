//
//  LoginViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    var loginPresenter:ViewToPresenterLoginProtocol?
    private let imageView = UIImageView()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let loginButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginRouter.createModule(ref: self, navigationController: navigationController!)
        style()
        layout()
        
    }
}

extension LoginViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        
        imageView.configureImageView(imageName: "chat")
        
        emailTxtFld.configureStyle(placeHolder: "  Email adress...", txtColor: .black)
        
        passwordTxtFld.configureStyle(placeHolder: "  Password...", txtColor: .black)
        
        loginButton.configureButton(title: "Login")
        
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(emailTxtFld)
        view.addSubview(passwordTxtFld)
        view.addSubview(loginButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.top).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.height/3)
            make.width.equalTo(view.width)
        }
        
        emailTxtFld.snp.makeConstraints { make in
            make.left.equalTo(view.left).offset(20)
            make.right.equalTo(view.right).offset(-20)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.height.equalTo(40)
        }
        
        passwordTxtFld.snp.makeConstraints { make in
            make.left.equalTo(view.left).offset(20)
            make.right.equalTo(view.right).offset(-20)
            make.top.equalTo(emailTxtFld.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(view.left).offset(50)
            make.right.equalTo(view.right).offset(-50)
            make.height.equalTo(40)
            make.top.equalTo(passwordTxtFld.snp.bottom).offset(50)
            make.bottom.equalTo(view.bottom).offset(-300)
        }
        
      
    }
    
}
