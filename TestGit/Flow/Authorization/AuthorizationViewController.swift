//
//  ViewController.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 21.04.2022.
//

import UIKit

//MARK: - View controller
class AuthorizationViewController: UIViewController {
   
    func debugLogin() {
        #if DEBUG
                loginTextField.text = "myapp@swift.com"
                passwordTextField.text = "password12345"
        #endif
    }
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.image = UIImage(named: "BackGroundImage")
        }
    }
    @IBOutlet var loginButton: UIButton! {
        didSet {
            loginButton.setTitleColor(.black, for: .normal)
            loginButton.setTitle(Placeholder.enterTitle, for: .normal)
        }
    }
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.placeholder = Placeholder.loginPlaceholder
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.placeholder = Placeholder.passwordPlaceholder
        }
    }
    @IBOutlet var mainLabel: UILabel! {
        didSet {
            mainLabel.text = Placeholder.mainTitle
        }
    }
    @IBOutlet var acceptionLabel: UILabel! {
        didSet {
            acceptionLabel.text = Placeholder.termsTitle
        }
    }
    @IBOutlet var acceptionTermsSwitch: UISwitch! {
        didSet {
            acceptionTermsSwitch.onTintColor = .gray
            acceptionTermsSwitch.subviews[0].subviews[0].backgroundColor = .red
        }
    }
    var auth = UserContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        debugLogin()
    }
    
    func pushListVC() {
        let storyboard = UIStoryboard(name: "ListView", bundle: nil)
        guard  let listViewController = storyboard.instantiateViewController(identifier: "ListViewControllerID") as? ListViewController else { return  }
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func saveData() {
        auth.login = loginTextField.text
        auth.login = loginTextField.text
    }
    
    @IBAction func loginButtonPressed(_ sender: CustomButton) {
        textFieldValidation()
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        
    }
    
    //MARK: - KeyboardFrame
    private func setupKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide),name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - ( 150 - 8 )
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - Validation
    private func textFieldValidation() {
        guard let loginText = loginTextField.text, loginText.isEmpty == false else {
            doNotPassValidationAlert(ErrorMessages.emptyField)
            return
        }
        guard let passwordText = passwordTextField.text, passwordText.isEmpty == false else {
            doNotPassValidationAlert(ErrorMessages.emptyField)
            return
        }
        guard acceptionTermsSwitch.isOn == true  else {
            doNotPassValidationAlert(ErrorMessages.incorrectSwitchStatus)
            return
        }
        guard let emailText = loginTextField.text, emailText.isValidEmail() else {
            doNotPassValidationAlert(ErrorMessages.incorrectEmail)
            return
        }
        auth.isAuth = true
        saveData()
    }
    
    private func doNotPassValidationAlert(_ messageConstant:String) {
        let alert = UIAlertController(title: "Ошибка", message: "\(messageConstant)", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
