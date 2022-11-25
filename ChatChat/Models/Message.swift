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


extension MessageKind {
    
    var messageKindString:String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributedText"
        case .photo(_):
            return "mediaItem"
        case .video(_):
            return "mediaItem"
        case .location(_):
            return "locationItem"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audioItem"
        case .contact(_):
            return "contactItem"
        case .linkPreview(_):
            return "linkItem"
        case .custom(_):
            return "optional"
        }
    }
}
