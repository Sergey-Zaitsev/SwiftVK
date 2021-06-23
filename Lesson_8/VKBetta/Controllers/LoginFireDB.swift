//
//  LoginFireDB.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 21.06.2021.
//

import UIKit
import FirebaseAuth

class LoginFireDB: UIViewController {

    lazy var auth = FirebaseAuth.Auth.auth()
    var authListener: AuthStateDidChangeListenerHandle!
     
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var passwordDidField: UITextField!
        @IBOutlet weak var loginDidField: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authListener = auth.addStateDidChangeListener { [weak self] (auth, user) in
            guard let _ = user else { return }
            self?.performSegue(withIdentifier: "Home", sender: nil)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        auth.removeStateDidChangeListener(authListener)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginDidField.text = nil
        passwordDidField.text = nil
    }
    
    @objc func keyboardWillShow(notification: Notification) {
            guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
            scrollView.contentInset = insets
        }
        @objc func keyboardWillHide (notification: Notification){
            let insets = UIEdgeInsets.zero
            scrollView.contentInset = insets
        }
        @IBAction func bottonTapAutorization(_ sender: UIButton) {
            
            guard
                let
                    email = loginDidField.text,
                    email.isEmpty == false,
                let password = passwordDidField.text,
                    password.isEmpty == false
            else {
                showAlert("Введите логин и пароль!")
                return
            }
            loginUser(email: email, password: password)
        }
        @IBAction func registration(_ sender: UIButton) {
            showRegistrationAlert { [ weak self ] email, password in
                self?.createUser(email: email, password: password)
            }
        }
//        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//            let result = checkUserCredentials()
//            if !result {
//                showAlert()
//            }
//            return result
//        }
//        func checkUserCredentials () -> Bool {
//            loginDidField.text == "" && passwordDidField.text == ""
//        }
    func showAlert (_ message: String) {
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    private func showRegistrationAlert (completion: @escaping (String, String) -> Void) {
            let alertController = UIAlertController(
                title: "Регистрация",
                message: nil,
                preferredStyle: .alert
            )
            alertController.addTextField {
                $0.placeholder = "Введите email"
            }
            alertController.addTextField {
                $0.isSecureTextEntry = true
                $0.placeholder = "Введите пароль"
            }
            
            let saveAction = UIAlertAction(
                title: "Сохранить",
                style: .default) { action in
                    guard
                        let email = alertController.textFields?.first?.text,
                        let password = alertController.textFields?.last?.text
                        else { return }
                    completion(email, password)
            }
            let cancelAction = UIAlertAction(
                title: "Отмена",
                style: .cancel,
                handler: nil
            )
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    

//    ------
    
    private func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [ weak self ] result, error in
            if let error = error {
                self?.showAlert(error.localizedDescription)
                return
            }
            
        }
    
    }
    private func createUser(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] (result, error) in
            
            if let error = error {
                self?.showAlert(error.localizedDescription)
                return
            }
            
            self?.loginUser(email: email, password: password)
        }
    }
}
