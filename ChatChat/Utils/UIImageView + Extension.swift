//
//  UIImageView + Extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit


extension UIImageView {
    
    func configureImageView(imageName:String){
        
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: imageName)
        contentMode = .scaleAspectFit
    }
    
}
