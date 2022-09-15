//
//  AuthViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

protocol AuthViewControllerDelegate {
    func showAlert(text: String)
}

class AuthViewModel {
    var auth = UserContext()
    var delegate: AuthViewControllerDelegate?
    
    func login(login: String?, password: String?, state: UISwitch) {
        guard let loginText = login, loginText.isEmpty == false else {
            delegate?.showAlert(text: ErrorMessages.emptyField)
            return
        }
        guard let passwordText = password, passwordText.isEmpty == false else {
            delegate?.showAlert(text: ErrorMessages.emptyField)
            return
        }
        guard state.isOn == true else {
            delegate?.showAlert(text: ErrorMessages.incorrectSwitchStatus)
            return
        }
        guard let emailText = login, emailText.isValidEmail() else {
            delegate?.showAlert(text: ErrorMessages.incorrectEmail)
            return
        }
        auth.login = login
        auth.password = password
        auth.isAuth = true
    }
}
