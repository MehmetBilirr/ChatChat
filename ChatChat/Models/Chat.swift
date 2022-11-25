//
//  Chat.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation


struct Chat:Codable {
    let content:String
    let date:String
    let isRead:Bool
    let receiverId:String
    let senderId:String
    let type:String
}


