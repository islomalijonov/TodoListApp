//
//  Extensions.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexString: String = (hexSanitized as NSString).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
