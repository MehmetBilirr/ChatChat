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


// MARK: - Get and Fetch UserData
class DataBaseManager {
    static let shared = DataBaseManager()
    let firestore = Firestore.firestore()
    let auth  = Auth.auth()
    init(){}
    
    
    func createDataFirestore(with imageUrl:String,firstName:String,lastName:String,email:String){
        
        createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName, email: email)
        
    }
    
    func setupProfile(imageView:UIImageView,firstName:String,lastName:String,email:String,completion:@escaping(Bool)-> Void){
        
        
        getImageUrl(imageView: imageView) { imageUrl in
            self.createDataFirestore(imageUrl: imageUrl, firstName: firstName, lastName: lastName, email: email)
            completion(true)
        }
        
    }
    
    func fetchUsers(completion:@escaping ([User])->Void){
        guard let uid = auth.currentUser?.uid else {return}
        var users = [User]()
        firestore.collection("users").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                if document.documentID != uid {
                    do {
                        let user = try document.data(as: User.self)
                        users.append(user)
                    }catch {
                        print(error.localizedDescription)
                    }
                }
                
                
                
            }
            completion(users)
            
        }
        
        
    }
    
    func checkIfUserLogin(completion:@escaping(Bool) -> Void) {
        guard let uid = auth.currentUser?.uid else {return}
        
        firestore.collection("users").document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            completion(snapshot.exists)
        }
        
    }
    
    
    private func createDataFirestore(imageUrl:String,firstName:String,lastName:String,email:String){
        
        guard let uid = auth.currentUser?.uid else {return}
        
        
        let data = [
            "firstName":firstName,
            "lastName":lastName,
            "imageUrl":imageUrl,
            "email":email,
            "uid":uid,
        ] as [String : Any]
        
        firestore.collection("users").document(uid).setData(data) { error in
            
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
    
    func fetchUser(uuid:String,completion:@escaping (User)->Void){
        
        Firestore.firestore().collection("users").document(uuid).getDocument { snapshot, error in
            guard let snaphot = snapshot else {return}
            
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
    
    
    
}

// MARK: - Sending Messages & Conversation
extension DataBaseManager {
    
    func createNewConversation(receiverUser:User,firstMessage:Message,completion:@escaping (Bool)-> Void) {
      
        var message = ""
        var currentUserName = ""
        guard let uid = auth.currentUser?.uid , let email = auth.currentUser?.email else {return}
        let messageDate = firstMessage.sentDate.dateAndTimetoString()
        
        switch firstMessage.kind {
            
        case .text(let messageText):
            message = messageText
        case .attributedText(_):
            break
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        
        let senderData : [String:Any] = [
            "user_id":receiverUser.uid,
            "user_name":"\(receiverUser.firstName) \(receiverUser.lastName)",
            "user_imageUrl":receiverUser.imageUrl,
            "latest_message": [
                "date":messageDate,
                "message":message,
                "isRead":false
            ]
        ]
        
        firestore.collection("conversations").document(uid).collection(uid).document(receiverUser.uid).setData(senderData) { error in
            
            guard let error = error else {
                print(error?.localizedDescription)
                return
            }
            
        }
        
        fetchUser(uuid: uid) { user in
            
            currentUserName = "\(user.firstName) \(user.lastName)"
            
            let recivierData:[String:Any] = [
                "user_id":uid,
                "user_name":currentUserName,
                "user_imageUrl":user.imageUrl,
                "latest_message":["date":messageDate,
                                  "message":message,
                                  "isRead":false]]
            
            self.firestore.collection("conversations").document(receiverUser.uid).collection(receiverUser.uid).document(uid).setData(recivierData) { error in
                guard let error = error else {
                    print(error?.localizedDescription)
                    return
                }
            }
        }
        
        
        
        
    }
    
    func getConversations(completion:@escaping ([Conversation])->Void){
        var conversationArray = [Conversation]()
        guard let uid = auth.currentUser?.uid else {return}
        firestore.collection("conversations").document(uid).collection(uid).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                do {
                    let conversation = try document.data(as: Conversation.self)
                    conversationArray.append(conversation)
                }catch {
                    print(error.localizedDescription)
                }
            }
            completion(conversationArray)
        }
    }
    
}
