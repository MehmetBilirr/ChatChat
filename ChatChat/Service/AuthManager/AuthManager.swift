//
//  UserService.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import FirebaseAuth
import ProgressHUD

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
    
    
    func firebsaseSignUp(email:String,password:String,completion:@escaping(Bool) -> Void){
        
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
    
}
