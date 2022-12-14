//
//  LoginViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import SnapKit
import FacebookLogin
import FirebaseAuth
import GoogleSignIn
import Firebase




final class LoginViewController: UIViewController {
    var loginPresenter:ViewToPresenterLoginProtocol?
    private let fbLoginButton = FBLoginButton()
    let googleSignInButton = GIDSignInButton()
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
        view.applyGradient(isVertical: false, colorArray: [.systemBlue.lighter(),.systemGreen.lighter()])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister(_:)))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chat")
        imageView.contentMode = .scaleAspectFit
        
        emailTxtFld.configureStyle(placeHolder: "  Email adress...", txtColor: .black)
        
        passwordTxtFld.configureStyle(placeHolder: "  Password...", txtColor: .black)
        passwordTxtFld.isSecureTextEntry = true
        passwordTxtFld.enablePasswordToggle()
        
        loginButton.configureButton(title: "Login", backgroundClr: .secondaryLabel)
        loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
    
        
        fbLoginButton.permissions = ["email","public_profile"]
        fbLoginButton.delegate = self
        
        googleSignInButton.addTarget(self, action: #selector(didtapGoogle), for: .touchUpInside)
        
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
            make.width.equalTo(view.width/2)
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
        }
        view.addSubview(fbLoginButton)
        fbLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            
        }
        
        view.addSubview(googleSignInButton)
        googleSignInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(fbLoginButton.snp.bottom).offset(20)
            
        }
      
    }
    
    @objc func didTapLogin(_ sender:UIButton){
        guard let mail = emailTxtFld.text, let pass = passwordTxtFld.text else {return}
        loginPresenter?.login(email: mail, password: pass)
    }
    
    @objc func didTapRegister(_ sender:UIButton) {
        loginPresenter?.register()
        passwordTxtFld.text = ""
        emailTxtFld.text = ""
    }
    
    @objc func didtapGoogle(){
        
        loginPresenter?.loginWithGoogle(viewController: self)
    }

    
}

extension LoginViewController:LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {return}
        loginPresenter?.loginWithFB(token: token)
        
        
    }
    
    
}







