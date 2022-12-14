//
//  UserService.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import FirebaseAuth
import ProgressHUD
import Firebase
import GoogleSignIn

class AuthManager {
    
    static let shared = AuthManager()
    init(){}
    private let auth = Auth.auth()
    
    func firebaseSignIn(email:String,password:String,completion:@escaping(Bool)->Void){
        
        auth.signIn(withEmail: email, password: password) { data, error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    completion(false)
    
                }else {
                    
                    completion(true)
                }
            }
        }
    
    
    func firebaseSignUp(email:String,password:String,completion:@escaping(Bool) -> Void){
        
        auth.createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                completion(false)
                
            }else {
                completion(true)
            }
            
        }
        
        
    }
    
    func firebaseLogOut(completion:@escaping(Bool)->Void){
        DataBaseManager.shared.updateStatus(status: .Offline)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            do {
                
                try self.auth.signOut()
                completion(true)
            }catch{
                completion(false)
                
            }
        })
            
        
           
       }
    
    func firebaseSignInWithFB(token:String){
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        auth.signIn(with: credential)
    }
    
    func firebaseSignInWithGoogle(viewController:UIViewController,completion:@escaping(Bool)->Void){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) {  (user, error) in

          if let error = error {
              print(error.localizedDescription)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken else {return}
            
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            self.auth.signIn(with: credential)
            completion(true)
        }
    }
    
    func changePassword(newPass:String) {
        auth.currentUser?.updatePassword(to: newPass, completion: { error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            }else {
                ProgressHUD.showSucceed()
            }
        })
    }
    func deleteAccount(completion:@escaping (Bool)-> Void){
        DataBaseManager.shared.deleteUserData { bool in
            if bool {
                self.auth.currentUser?.delete(completion: { error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }else {
                        completion(true)
                    }
                })
            }
        }
    }
}
