//
//  CoreExtensions.swift
//  Abbiocco-iOS
//
//  Created by Noirdemort on 17/02/19.
//  Copyright © 2019 Noirdemort. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


@IBDesignable class RoundImage: UIImageView{
    
//    @IBInspectable var borderWidth: CGFloat = 0.2
//    @IBInspectable var borderColor: UIColor = UIColor.green
    @IBInspectable var makeCircular: Bool = true
    @IBInspectable var cornerRadius: CGFloat = 0.3
    
    override func layoutSubviews() {
//        layer.borderWidth = borderWidth
//        layer.borderColor = borderColor.cgColor
        if makeCircular {
            cornerRadius = min(bounds.width, bounds.height) / 2.0
        }
        layer.cornerRadius = cornerRadius
    }
}
