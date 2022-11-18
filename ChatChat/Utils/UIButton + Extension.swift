//
//  UIButton + Extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit



extension UIButton {
    
    func configureButton(title:String) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        setTitleColor(.white, for: .normal)
        backgroundColor = .link
    }
    
}
