//
//  AuthViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

protocol AlertError {
    func alertError (alertText: String)
}
class AuthViewModel {
    
    var auth = UserContext()
    var errorMessage: Observable<String?> = Observable(nil)
 //   var errorAlert : Observable<UIAlertAction?> = Observable(nil)
    func Login (login: String?, password: String?,state: UISwitch) {
        guard let loginText = login, loginText.isEmpty == false else {
            print(ErrorMessages.emptyField)
            return errorMessage.value = ErrorMessages.emptyField
        }
        guard let passwordText = password, passwordText.isEmpty == false else {
            print(ErrorMessages.emptyField)
            return errorMessage.value = ErrorMessages.emptyField
        }
        guard  state.isOn == true else {
            print(ErrorMessages.incorrectSwitchStatus)
            return errorMessage.value = ErrorMessages.incorrectSwitchStatus
        }
        guard let emailText = login, emailText.isValidEmail() else {
            print(ErrorMessages.incorrectEmail)
            return errorMessage.value = ErrorMessages.incorrectEmail
        }
        auth.login = login
        auth.password = password
        auth.isAuth = true
    }
}

