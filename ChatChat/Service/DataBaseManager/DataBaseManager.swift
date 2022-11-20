//
//  DataBaseManager.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class DataBaseManager {
    static let shared = DataBaseManager()
    init(){}
    
    func createDataFirestore(with imageUrl:String,firstName:String,lastName:String,completion:@escaping(Bool)-> Void){
        
        createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName)
        
    }
    
    func setupProfile(imageView:UIImageView,firstName:String,lastName:String,completion:@escaping(Bool)-> Void){
        
        
        getImageUrl(imageView: imageView) { imageUrl in
            self.createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName)
            completion(true)
        }
        
    }
    
    private func createDataFirestore(imageUrl:String,firstName:String,lastName:String){
        
        guard let user = Auth.auth().currentUser else {return}
        
        
        let data = [
                    "fistName":firstName,
                    "lastName":lastName,
                    "imageUrl":imageUrl,
                    "uid":user.uid,
                    ] as [String : Any]
        
        Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
            
            guard let error = error else {
                print(error?.localizedDescription)
                return
            }
            
        }
        
    }
    

    
     private func getImageUrl(imageView:UIImageView,completion:@escaping(String)->Void){
        
        guard let data = imageView.image?.jpegData(compressionQuality: 0.5) else {return }
        let uuid = UUID().uuidString
        
        let ref = Storage.storage().reference().child("media").child("\(uuid).jpg")
        ref.putData(data) { metada, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                ref.downloadURL { imageUrl, error in
                    
                    guard let imageUrl = imageUrl?.absoluteString else{return}
                        completion(imageUrl)
                       
                        
                    }
                    
                }
            }
            
        }
}
