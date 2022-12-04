//
//  UIColor + Extension.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 4.12.2022.
//

import Foundation
import UIKit

extension UIColor {
    func lighter(componentDelta: CGFloat = 0.4) -> UIColor {
        return makeColor(componentDelta: componentDelta)
    }
    
    func darker(componentDelta: CGFloat = 0.05) -> UIColor {
        return makeColor(componentDelta: -1*componentDelta)
    }
    
    
    private func makeColor(componentDelta: CGFloat) -> UIColor {
            var red: CGFloat = 0
            var blue: CGFloat = 0
            var green: CGFloat = 0
            var alpha: CGFloat = 0
            
            // Extract r,g,b,a components from the
            // current UIColor
            getRed(
                &red,
                green: &green,
                blue: &blue,
                alpha: &alpha
            )
            
            // Create a new UIColor modifying each component
            // by componentDelta, making the new UIColor either
            // lighter or darker.
            return UIColor(
                red: add(componentDelta, toComponent: red),
                green: add(componentDelta, toComponent: green),
                blue: add(componentDelta, toComponent: blue),
                alpha: alpha
            )
        }
    
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
            return max(0, min(1, toComponent + value))
        }
}
