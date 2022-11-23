//
//  ChatUser.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 20.11.2022.
//

import Foundation

struct User:Codable {
    let firstName:String
    let lastName:String
    let uid:String
    let imageUrl:String
    let email:String
}