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
    
    func firebaseSignIn(email:String,password:String,completion:@escaping(Bool)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { data, error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    completion(false)
    
                }else {
                    
                    completion(true)
                }
            }
        }
    
    
    func firebaseSignUp(email:String,password:String,completion:@escaping(Bool) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                completion(false)
                
            }else {
                completion(true)
            }
            
        }
    }
    
    func firebaseLogOut(completion:(Bool)->Void){
           do {
               try Auth.auth().signOut()
               completion(true)
           }catch{
               completion(false)
               ProgressHUD.showError(error.localizedDescription)
           }
       }
    
    func firebaseSignInWithFB(token:String){
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential)
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

            Auth.auth().signIn(with: credential)
            completion(true)
        }
    }
    
}
