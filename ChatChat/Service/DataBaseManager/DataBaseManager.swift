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
import MapKit


// MARK: - Get and Fetch UserData
class DataBaseManager {
    static let shared = DataBaseManager()
    let firestore = Firestore.firestore()
    let auth  = Auth.auth()
    private var uid:String  {
        guard let uid = auth.currentUser?.uid else {return ""}
        return uid
    }
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
        var users = [User]()
        firestore.collection("users").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                if document.documentID != self.uid {
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
        firestore.collection("users").document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            completion(snapshot.exists)
        }
        
    }
    
    
    private func createDataFirestore(imageUrl:String,firstName:String,lastName:String,email:String){
        let data = [
            "firstName":firstName,
            "lastName":lastName,
            "imageUrl":imageUrl,
            "email":email,
            "uid":uid
        ] as [String : Any]
        
        firestore.collection("users").document(uid).setData(data) { error in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
        }
        
    }
    
    func updateStatus(status:Status){
        guard let uid = auth.currentUser?.uid else {return}
        firestore.collection("users").document(uid).updateData(["status":status.rawValue]) { error in
            
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
    
    func fetchUserAddSnapshotListener(uuid:String,completion:@escaping (User)->Void){
        
        Firestore.firestore().collection("users").document(uuid).addSnapshotListener { snapshot, error in
            guard let snaphot = snapshot else {return}
            
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
    
    private func fetchUser(uuid:String,completion:@escaping (User)->Void) {
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
        case .location(let locationData):
            let location = locationData.location
            message = "\(location.coordinate.longitude),\(location.coordinate.latitude)"

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
        
        createConversationForOtherUser(Id: receiverUserId, messageDate: messageDate, message: message) { [weak self] bool in
            if bool {
                self?.createConversationForCurrentUser(otherId: receiverUserId, messageDate: messageDate, message: message) { [weak self] bool in
                    if bool {
                        self?.createChat(receiverUserId: receiverUserId, type: firstMessage.kind.messageKindString, date: messageDate, content: message, completion: completion)
                    }
                }
            }
        }
    
        
        
        
    }
    
    private func createConversationForCurrentUser(otherId:String,messageDate:String,message:String,completion:@escaping(Bool)-> Void){
        fetchUser(uuid: uid) { user in
            
            let currentUserName = "\(user.firstName) \(user.lastName)"
            
            let recivierData:[String:Any] = [
                "user_id":self.uid,
                "user_name":currentUserName,
                "user_imageUrl":user.imageUrl,
                "latest_message":["date":messageDate,
                                  "message":message,
                                  "isRead":false]]
            
            self.firestore.collection("conversations").document(otherId).collection(otherId).document(self.uid).setData(recivierData) { error in
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false)
                }else {
                    completion(true)
                }
            }
        }
    }
    
    private func createConversationForOtherUser(Id:String,messageDate:String,message:String,completion:@escaping(Bool)-> Void){
        fetchUser(uuid: Id) { user in
            let currentUserName = "\(user.firstName) \(user.lastName)"
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
            self.firestore.collection("conversations").document(self.uid).collection(self.uid).document(Id).setData(senderData) { error in
                
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false)
                }else {
                    completion(true)
                }
                
            }
        }
    }
    
     private func createChat(receiverUserId:String,type:String,date:String,content:String,completion:@escaping (Bool)-> Void){
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
            self.firestore.collection("chats").document(receiverUserId).collection(self.uid).addDocument(data: data) { error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                completion(true)
            }
            
        }
        
    }
    
    func getConversations(completion:@escaping ([Conversation])->Void){
        var conversationArray = [Conversation]()
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
                    }else if (chat.type == "location") {
                        let locationComponents = chat.content.components(separatedBy: ",")
                        guard let longitude = Double(locationComponents[0]),
                              let latitude = Double(locationComponents[1]) else {return completion(.failure(AppError.unknownError))}
                        let location = Location(location:CLLocation(latitude: latitude, longitude: longitude) ,
                                                size: CGSize(width: 300, height: 300))
                        messageKind = .location(location)
                        
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
        
        self.firestore.collection("conversations").document(uid).collection(uid).document(otherId).delete { error in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
            }else {
                self.firestore.collection("chats").document(self.uid).collection(otherId).getDocuments { snapshot, error in
                    guard let documents = snapshot?.documents else {return}
                    documents.forEach { document in
                        let documentId = document.documentID
                        self.firestore.collection("chats").document(self.uid).collection(otherId).document(documentId).delete { error in
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
    
    func deleteUserData(completion:@escaping (Bool)-> Void){
        
        firestore.collection("users").document(uid).delete { error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                self.firestore.collection("conversations").document(self.uid).delete { error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }else {
                        self.firestore.collection("chats").document(self.uid).delete { error in
                            if error != nil {
                                print(error?.localizedDescription)
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
