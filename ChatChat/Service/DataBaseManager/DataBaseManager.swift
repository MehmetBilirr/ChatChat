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
import MessageKit


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
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
        }
        
    }
    
    
    
    func getImageUrl(imageView:UIImageView,completion:@escaping(String)->Void){
        
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
    
    func createNewConversation(receiverUserId:String,firstMessage:Message,completion:@escaping (Bool)-> Void) {
      
        var message = ""
        var currentUserName = ""
        guard let uid = auth.currentUser?.uid else {return}
        let messageDate = firstMessage.sentDate.dateAndTimetoString()
        
        switch firstMessage.kind {
            
        case .text(let messageText):
            message = messageText
        case .attributedText(_):
            break
        case .photo(let mediaItem):
            if let urlString = mediaItem.url?.absoluteString {
                message = urlString
            }
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
        fetchUser(uuid: receiverUserId) { user in
            currentUserName = "\(user.firstName) \(user.lastName)"
            let senderData : [String:Any] = [
                "user_id":user.uid,
                "user_name":currentUserName,
                "user_imageUrl":user.imageUrl,
                "latest_message":[
                    "date":messageDate,
                    "message":message,
                    "isRead":false
                ]
            ]
            self.firestore.collection("conversations").document(uid).collection(uid).document(receiverUserId).setData(senderData) { error in
                
                if error != nil {
                    print(error?.localizedDescription)
                }
                
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
            
            self.firestore.collection("conversations").document(receiverUserId).collection(receiverUserId).document(uid).setData(recivierData) { error in
                if error != nil {
                    print(error?.localizedDescription)
                }
            }
        }
        
        createChat(receiverUserId: receiverUserId, type: firstMessage.kind.messageKindString, date: messageDate, content: message, completion: completion)
        
        
    }
    
     private func createChat(receiverUserId:String,type:String,date:String,content:String,completion:@escaping (Bool)-> Void){
        guard let uid = auth.currentUser?.uid else {return}
        let data : [String:Any] = [
            "receiverId":receiverUserId,
            "type":type,
            "content":content,
            "date":date,
            "senderId":uid,
            "isRead":false
            ]
         
        
        firestore.collection("chats").document(uid).collection(receiverUserId).addDocument(data: data) { error in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
        }
        
        firestore.collection("chats").document(receiverUserId).collection(uid).addDocument(data: data) { error in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        completion(true)
        
        
        
        
    }
    
    func getConversations(completion:@escaping ([Conversation])->Void){
        var conversationArray = [Conversation]()
        guard let uid = auth.currentUser?.uid else {return}
        firestore.collection("conversations").document(uid).collection(uid).addSnapshotListener({ snapshot, error in
            
           
                guard let documents = snapshot?.documents else {return}
            conversationArray.removeAll(keepingCapacity: true)
                documents.forEach { document in
                    do {
                        let conversation = try document.data(as: Conversation.self)
                        conversationArray.append(conversation)
                    }catch {
                        print(error.localizedDescription)
                    }
                }
               
                completion(conversationArray.sorted(by: {$0.latest_message.date > $1.latest_message.date}))
        })
        
    }
    
    
    func getChats(otherId:String,completion:@escaping (Result<[Message],Error>)->Void) {
        var messageArray = [Message]()
        guard let uid = auth.currentUser?.uid else {return}
        firestore.collection("chats").document(uid).collection(otherId).order(by: "date", descending: false).addSnapshotListener({ snapshot, error in
            guard let documents = snapshot?.documents else {
                completion(.failure(AppError.serverError("There is no documents")))
                return}
            messageArray.removeAll(keepingCapacity: true)
            documents.forEach { document in
                do {
                    let chat = try document.data(as: Chat.self)
                    var messageKind:MessageKind?
                    if chat.type == "photo" {
                        let media = Media(url: URL(string: chat.content),
                                          image: nil,
                                          placeholderImage: UIImage(systemName: "plus")!,
                                          size: CGSize(width: 300, height: 300))
                        messageKind = .photo(media)
                    } else  {
                        messageKind = .text(chat.content)
                    }
                    guard let finalKind = messageKind else {return}
                    let sender = Sender(photoURL: "", senderId: chat.senderId, displayName: "")
                    let message  = Message(sender: sender, messageId: chat.receiverId, sentDate: chat.date.convertToDate(), kind: finalKind)
                    messageArray.append(message)
                }catch {
                    completion(.failure(AppError.errorDecoding))
                }
            }
           
            completion(.success(messageArray))
        })
    }
    
    func deleteConversations(otherId:String,completion: @escaping (Bool)->Void) {
        let firestore = Firestore.firestore()
        guard let uid = auth.currentUser?.uid else {return}
        firestore.collection("conversations").document(uid).collection(uid).document(otherId).delete { error in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
            }else {
                firestore.collection("chats").document(uid).collection(otherId).addSnapshotListener { snapshot, error in
                    guard let documents = snapshot?.documents else {return}
                    documents.forEach { document in
                        let documentId = document.documentID
                        firestore.collection("chats").document(uid).collection(otherId).document(documentId).delete { error in
                            if error != nil {
                                print(error?.localizedDescription)
                                completion(false)
                            }else {
                                completion(true)
                            }
                        }
                    }
                }
            }
        }
    }
}
