//
//  UIStackView + extension.swift.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


extension UIStackView {
    
    func configureStyle(axiS:NSLayoutConstraint.Axis,space:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        axis = axiS
        spacing = space
    }
}
