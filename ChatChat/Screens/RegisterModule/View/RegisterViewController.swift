//
//  RegisterViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {
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
        
        RegisterRouter.createModule(ref: self, navigationController: navigationController!)
    }
    

}

extension RegisterViewController {
    
    func style(){
        view.applyGradient(isVertical: false, colorArray: [.systemGreen.lighter(),.systemBlue.lighter()])
        
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "person")
 
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        nameTxtFld.configureStyle(placeHolder: "First Name...", txtColor: .black)
        nameTxtFld.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        
        lastNameTxtFld.configureStyle(placeHolder: "Last Name...", txtColor: .black)
        
        emailTxtFld.configureStyle(placeHolder: "Email Adress...", txtColor: .black)
        
        passwordTxtFld.configureStyle(placeHolder: "Password", txtColor: .black)
        passwordTxtFld.isSecureTextEntry = true
        
        stackView.configureStyle(axiS: .vertical, space: 20)
        
        registerButton.configureButton(title: "Register", backgroundClr: .secondaryLabel)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    func layout(){
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(200)
        }
        
        stackView.addArrangedSubview(nameTxtFld)
        stackView.addArrangedSubview(lastNameTxtFld)
        stackView.addArrangedSubview(emailTxtFld)
        stackView.addArrangedSubview(passwordTxtFld)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(imageView.snp.bottom).offset(50)
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
    
    @objc func didTapRegisterButton(){
        guard let firstName = nameTxtFld.text, let lastName = lastNameTxtFld.text, let email = emailTxtFld.text, let password = passwordTxtFld.text else {return}
        
        registerPresenter?.register(profileImageView: imageView, firstName: firstName, lastName: lastName, email: email, password: password)
    }

    
}


extension RegisterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func didTapImageActions(){
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        actionSheet.configureAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.configureAction(title: "Take Photo", style: .default) { [weak self] _ in
            self?.presentCamera()
        }
        
        actionSheet.configureAction(title: "Chose Photo", style: .default) {[weak self] _ in
            self?.presentPhotoPicker()
        }
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func didTapImage(_ sender:UIGestureRecognizer) {
       didTapImageActions()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
