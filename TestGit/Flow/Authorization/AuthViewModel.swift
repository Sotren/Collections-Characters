//
//  AuthViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

class AuthViewModel {
    
    var auth = UserContext()
    var errorMessage: Observable<String?> = Observable(nil)
 //   var errorAlert : Observable<UIAlertAction?> = Observable(nil)
    func Login (login: String?, password: String?,state: UISwitch) {
        guard let loginText = login, loginText.isEmpty == false else {
            print(ErrorMessages.emptyField)
            return
        }
        guard let passwordText = password, passwordText.isEmpty == false else {
            print(ErrorMessages.emptyField)
//            doNotPassValidationAlert(ErrorMessages.emptyField)
            return
        }
        guard  state.isOn == true else {
            print(ErrorMessages.incorrectSwitchStatus)
            return
        }
        guard let emailText = login, emailText.isValidEmail() else {
            print(ErrorMessages.incorrectEmail)
            return
        }
        auth.login = login
        auth.password = password
        auth.isAuth = true
    }
    
//    private func doNotPassValidationAlert(_ messageConstant:String) {
//        let alert = UIAlertController(title: "Ошибка", message: "\(messageConstant)", preferredStyle: UIAlertController.Style.alert)
//        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
//        alert.addAction(okButton)
//       // present(alert, animated: true, completion: nil)
//    }
    
}
