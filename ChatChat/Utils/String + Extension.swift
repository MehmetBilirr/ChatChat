//
//  String + Extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 28.11.2022.
//

import Foundation

extension String {
    
    func convertToDate(format: String = "yyyy-MM-dd HH:mm")-> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.date(from: self) ?? Date()
    }
}
