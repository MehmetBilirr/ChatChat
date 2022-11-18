//
//  RegisterViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    private let nameTxtFld = UITextField()
    private let lastNameTxtFld = UITextField()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let registerButton = UIButton()
    var registerPresenter:ViewToPresenterRegisterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    

}

extension RegisterViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        
        imageView.configureImageView(imageName: "person")
        
        nameTxtFld.configureStyle(placeHolder: "First Name...", txtColor: .black)
        nameTxtFld.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        
        lastNameTxtFld.configureStyle(placeHolder: "Last Name...", txtColor: .black)
        
        emailTxtFld.configureStyle(placeHolder: "Email Adress...", txtColor: .black)
        
        passwordTxtFld.configureStyle(placeHolder: "Password", txtColor: .black)
        
        stackView.configureStyle(axiS: .vertical, space: 20)
        
        registerButton.configureButton(title: "Register", backgroundClr: .secondaryLabel)
    }
    
    func layout(){
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(view.height / 5)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(view.width / 2)
        }
        
        stackView.addArrangedSubview(nameTxtFld)
        stackView.addArrangedSubview(lastNameTxtFld)
        stackView.addArrangedSubview(emailTxtFld)
        stackView.addArrangedSubview(passwordTxtFld)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalToSuperview().offset(view.height / 3)
        }
        
        for i in stackView.subviews  {
            i.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }
        
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-200)
        }
        
    }
}
