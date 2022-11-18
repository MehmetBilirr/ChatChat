//
//  UITextField + extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    
    func configureStyle(placeHolder:String,txtColor:UIColor){
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = placeHolder
        textColor = .black
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        leftViewMode = .always
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    func enablePasswordToggle(){
        
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender:UIButton) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
    
    
}
