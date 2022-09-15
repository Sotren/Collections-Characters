//
//  UITabelViewCell+Extension.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 10.05.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String (describing: self)
    }
}
