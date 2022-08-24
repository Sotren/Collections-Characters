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
    
    private let viewModel = AuthViewModel()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        debugLogin()
        setupBinders()
        viewModel.auth.isAuth = false
    }
    
    func pushListVC() {
        let storyboard = UIStoryboard(name: "ListView", bundle: nil)
        guard  let listViewController = storyboard.instantiateViewController(identifier: "ListViewControllerID") as? ListViewController else { return  }
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func setupBinders() {
        viewModel.errorMessage.bind { [weak self] error  in
            if  let error = error {
                self?.alertError(alertText: error)
            } else {
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: CustomButton) {
        viewModel.Login(login: loginTextField.text, password: passwordTextField.text, state: acceptionTermsSwitch)
        pushListVC()
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
}

extension AuthorizationViewController: AlertError {
    func alertError(alertText: String) {
        let alert = UIAlertController(title: "Ошибка", message: "\(alertText)", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
