//
//  UIAlertController + extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


extension UIAlertController {
    
    func configureAction(title:String,style:UIAlertAction.Style,handler:((UIAlertAction)-> Void)?){
        
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
}
