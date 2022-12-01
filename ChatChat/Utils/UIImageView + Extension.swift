//
//  UIImageView + Extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit


extension UIImageView {
    
    func configureImageView(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = self.frame.width / 2
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
}
