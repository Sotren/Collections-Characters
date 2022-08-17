//
//  CustomButton.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 28.04.2022.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable public  var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable public var backGroundColor: UIColor = UIColor.clear {
        didSet {
            self.layer.backgroundColor = self.backGroundColor.cgColor
        }
    }
}
