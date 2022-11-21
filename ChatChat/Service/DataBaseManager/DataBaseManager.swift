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
import FirebaseFirestoreSwift

class DataBaseManager {
    static let shared = DataBaseManager()
    init(){}
    
    func createDataFirestore(with imageUrl:String,firstName:String,lastName:String){
        
        createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName)
        
    }
    
    func setupProfile(imageView:UIImageView,firstName:String,lastName:String,completion:@escaping(Bool)-> Void){
        
        
        getImageUrl(imageView: imageView) { imageUrl in
            self.createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName)
            completion(true)
        }
        
    }
    
    func fetchUsers(completion:@escaping ([ChatUser])->Void){
        var users = [ChatUser]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                print(document.data())
                do {
                    let user = try document.data(as: ChatUser.self)
                    users.append(user)
                }catch {
                    print(error.localizedDescription)
                }
                
                
            }
            completion(users)
            
        }
        
        
    }
    
    func checkIfUserLogin(completion:@escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            completion(snapshot.exists)
        }
        
    }
    
    
    private func createDataFirestore(imageUrl:String,firstName:String,lastName:String){
        
        guard let user = Auth.auth().currentUser else {return}
        
        
        let data = [
                    "firstName":firstName,
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
