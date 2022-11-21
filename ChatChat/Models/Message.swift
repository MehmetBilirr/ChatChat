//
//  Message.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import MessageKit

struct Message:MessageType {
    
    var sender:SenderType
    var messageId: String
    var sentDate: Date
    var kind:MessageKind
}

struct Sender:SenderType {
    var photoURL:String
    var senderId: String
    var displayName: String
}
