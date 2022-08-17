//
//  Extension+String.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 05.05.2022.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "(?=.{1,30}$)[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]{1,10}\\.[A-Za-z]{1,10}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        }
    }

