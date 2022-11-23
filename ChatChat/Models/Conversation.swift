//
//  Conversation.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 23.11.2022.
//

import Foundation

struct Conversation:Codable {
    let latest_message:LatestMessage
    let user_id:String
    let user_name:String
}

struct LatestMessage:Codable {
    let date:String
    let message:String
    let isRead:Bool
}



